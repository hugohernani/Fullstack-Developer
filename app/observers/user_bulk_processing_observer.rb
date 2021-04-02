class UserBulkProcessingObserver
  def initialize(bulk_upload:, sheet_size:)
    @bulk_upload = bulk_upload
    @sheet_size = sheet_size
  end

  def update(current_row)
    process_completion = calc(current_row)

    bulk_upload.update_column(:processed_value, process_completion)
    broadcast
  end

  protected

  attr_reader :bulk_upload, :sheet_size

  def calc(current_row)
    (current_row.to_f / sheet_size) * 100
  end

  def broadcast
    BulkUploadsChannel.broadcast_to bulk_upload, progress_bar_template: progress_bar
  end

  def progress_bar
    ApplicationController.renderer.render(partial: 'admin/users/bulk/progress_bar',
                                          locals: { bulk_upload: bulk_upload })
  end
end

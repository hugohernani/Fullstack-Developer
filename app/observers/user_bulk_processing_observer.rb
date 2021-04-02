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
    BulkUploadsChannel.broadcast_to bulk_upload,
                                    progress_value: bulk_upload.processed_value,
                                    bulk_upload_id: bulk_upload.id
  end
end

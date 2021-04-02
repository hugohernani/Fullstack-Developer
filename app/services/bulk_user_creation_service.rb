class BulkUserCreationService
  include Observable

  def initialize(bulk_upload)
    @sheet = open_sheet(bulk_upload.file)
    add_observer(UserBulkProcessingObserver.new(bulk_upload: bulk_upload, sheet_size: sheet_size))
  end

  def perform(offset: 1, max_rows: 10)
    max_rows = update_max_rows(max_rows)
    sheet.each_row_streaming(pad_cells: true, offset: offset, max_rows: max_rows) do |row|
      create_user(row)
    end
    changed
    notify_observers(max_rows)
    perform(offset: max_rows + 1, max_rows: max_rows + 10) if max_rows < sheet_size
  end

  private

  attr_accessor :sheet

  def update_max_rows(max_rows)
    remaining_diff = (sheet_size - max_rows).abs
    remaining_diff < max_rows ? sheet_size : max_rows
  end

  def create_user(row)
    mapped_values = row.map(&:value)
    keyword_args = required_attributes.zip(mapped_values).to_h
    User.create!(keyword_args)
  rescue ActiveModel::UnknownAttributeError, ActiveRecord::RecordInvalid, ArgumentError => e
    log_error(row[0].coordinate, e)
  end

  def open_sheet(attached_file)
    file_extension = attached_file.filename.to_s.split('.').last
    Roo::Spreadsheet.open(file_path(attached_file.key), extension: file_extension, file_warning: :ignore)
  end

  def file_path(blob_key)
    ActiveStorage::Blob.service.path_for(blob_key)
  end

  def required_attributes
    %w[full_name email password role]
  end

  def sheet_size
    @sheet_size ||= sheet.last_row
  end

  def log_error(cell_coordinates, error)
    row_number, = cell_coordinates
    Rails.logger.warn "Error on row: #{row_number}"
    Rails.logger.warn error.inspect
  end
end

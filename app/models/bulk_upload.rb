class BulkUpload < ApplicationRecord
  belongs_to :uploader, class_name: 'User',
                        inverse_of: :bulk_uploads

  has_one_attached :file

  def file_name
    file.filename.to_s
  end
end

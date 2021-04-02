class BulkUpload < ApplicationRecord
  belongs_to :uploader, class_name: 'User',
                        inverse_of: :bulk_uploads

  # Associations
  has_one_attached :file

  validates :file,          attached: true,
                            size: { less_than: 2.megabytes },
                            content_type: [
                              'application/vnd.ms-excel',
                              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                            ]

  def file_name
    file.filename.to_s
  end
end

class BulkUploadJob < ApplicationJob
  queue_as :default

  def perform(bulk_upload)
    BulkUserCreationService.new(bulk_upload).perform
  end
end

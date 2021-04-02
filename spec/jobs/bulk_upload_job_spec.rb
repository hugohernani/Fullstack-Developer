require 'rails_helper'

RSpec.describe BulkUploadJob, type: :job do
  let(:bulk_user_create_service){ instance_double('bulkUserCreationService', perform: nil) }
  let(:bulk_user_creation_service_klass){ class_double('BulkUserCreationService', new: bulk_user_create_service) }
  let(:bulk_upload){ instance_double('Bulk Upload') }

  before do
    stub_const('BulkUserCreationService', bulk_user_creation_service_klass)
  end

  it 'delegates to Participant::CreateService the file processing' do
    described_class.perform_now(bulk_upload)

    expect(BulkUserCreationService).to have_received(:new).with(bulk_upload)
    expect(bulk_user_create_service).to have_received(:perform).once
  end
end

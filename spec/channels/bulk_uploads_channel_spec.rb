require 'rails_helper'

RSpec.describe BulkUploadsChannel, type: :channel do
  let!(:current_user) { create(:user) }
  let(:gid_param){ 42 }
  let(:bulk_upload){ instance_double('bulkUpload', id: gid_param, to_gid_param: gid_param) }

  it_behaves_like 'allowed logged in connection' do
    let(:logged_in_user) { current_user }
  end

  before do
    allow(BulkUpload).to receive(:find).and_return(bulk_upload)
    stub_connection current_user: current_user
  end

  it 'subscription to have been connected' do
    subscribe(upload_id: bulk_upload.id)
    expect(subscription).to be_confirmed
  end

  it 'streams from provided BulkUpload' do
    subscribe(upload_id: bulk_upload.id)
    expect(subscription).to have_stream_from("bulk_uploads:#{bulk_upload.to_gid_param}")
  end
end

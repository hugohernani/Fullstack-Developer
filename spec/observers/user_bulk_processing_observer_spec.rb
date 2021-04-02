require 'rails_helper'

describe UserBulkProcessingObserver do
  subject(:observer) { described_class.new(bulk_upload: bulk_upload, sheet_size: sheet_size) }

  let(:bulk_upload){ instance_double('bulkUpload', update_column: nil) }
  let(:sheet_size){ 50 }
  let(:uploads_channel_klass){ class_double('BulkUploadsChannel', broadcast_to: nil) }

  before do
    allow(ApplicationController).to receive_message_chain(:renderer, :render).and_return(nil)
    stub_const('BulkUploadsChannel', uploads_channel_klass)
  end

  it 'updates processed_value attribute on bulk_upload' do
    current_row = 10
    expected_result = (current_row.to_f / sheet_size) * 100
    observer.update(current_row)
    expect(bulk_upload).to have_received(:update_column).with(:processed_value, expected_result)
  end

  it 'asks ApplicationController to render a partial' do
    observer.update(10)
    expect(ApplicationController).to have_received(:renderer)
  end

  it 'broadcasts bulk_upload through BulkUploadsChannel' do
    observer.update(10)
    broadcast_expectation = { progress_bar_template: a_value }
    expect(uploads_channel_klass).to have_received(:broadcast_to).with(bulk_upload, broadcast_expectation)
  end
end

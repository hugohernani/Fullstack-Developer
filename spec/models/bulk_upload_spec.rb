require 'rails_helper'

RSpec.describe BulkUpload, type: :model do
  %i[uploader].each do |attr|
    it { is_expected.to belong_to(attr) }
  end

  describe 'with factory instance' do
    let(:bulk_upload){ create(:bulk_upload) }

    describe '#file_name' do
      it 'returns file name' do
        expect(bulk_upload.file_name).to eq(bulk_upload.file.filename.to_s)
      end
    end
  end
end

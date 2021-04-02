require 'rails_helper'

RSpec.describe BulkUpload, type: :model do
  %i[uploader].each do |attr|
    it { is_expected.to belong_to(attr) }
  end

  describe 'with factory instance' do
    let(:bulk_upload){ create(:bulk_upload) }

    it do
      expect(bulk_upload).to validate_content_type_of(:file).allowing(
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      )
    end

    it do
      expect(bulk_upload).to validate_size_of(:file).less_than(2.megabytes)
    end

    describe '#file_name' do
      it 'returns file name' do
        expect(bulk_upload.file_name).to eq(bulk_upload.file.filename.to_s)
      end
    end
  end
end

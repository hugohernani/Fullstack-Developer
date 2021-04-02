require 'rails_helper'

RSpec.describe BulkUploadPolicy, type: :policy do
  subject { described_class }

  let(:member) { instance_double('User', admin?: false) }
  let(:admin) { instance_double('User', admin?: true) }

  permissions :new?, :create? do
    it { is_expected.to permit(admin) }
    it { is_expected.not_to permit(member) }
  end

  permissions :show? do
    let(:admin){ create(:user, :admin) }

    context 'when admin is the owner' do
      let(:record){ create(:bulk_upload, uploader: admin) }

      it { is_expected.to permit(admin, record) }
    end

    context 'when admin is not the owner' do
      let(:record){ create(:bulk_upload) }

      it { is_expected.not_to permit(admin, record) }
    end
  end
end

require 'rails_helper'

describe ProfilePresenter, type: :presenter do
  subject(:presenter){ described_class.new(user, double) }

  it_behaves_like 'simple delegator presenter', described_class do
    let(:resource) { create(:user) }
  end

  describe '#edit_link' do
    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'returns admin scoped edit profile link' do
        expect(presenter.edit_link).to eq admin_edit_profile_path
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, :member) }

      it 'returns no admin scoped edit profile link' do
        expect(presenter.edit_link).to eq edit_profile_path
      end
    end
  end

  describe '#return_link' do
    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'returns admin scoped profile link' do
        expect(presenter.return_link).to eq admin_profile_path
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, :member) }

      it 'returns no admin scoped profile link' do
        expect(presenter.return_link).to eq profile_path
      end
    end
  end

  describe '#update_link' do
    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'returns admin scoped update profile link' do
        expect(presenter.update_link).to eq admin_update_profile_path
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, :member) }

      it 'returns no admin scoped update profile link' do
        expect(presenter.update_link).to eq update_profile_path
      end
    end
  end

end

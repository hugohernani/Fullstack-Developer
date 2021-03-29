require 'rails_helper'

RSpec.describe User, type: :model do
  %i[email full_name role].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  describe '#toggle_role' do
    context 'when user is an admin' do
      subject(:user) { create(:user, :admin) }

      it 'changes user role to member' do
        user.toggle_role

        expect(user.role).to eq('member')
      end
    end

    context 'when user is a member' do
      subject(:user) { create(:user, :member) }

      it 'changes user role to member' do
        user.toggle_role

        expect(user.role).to eq('admin')
      end
    end
  end
end

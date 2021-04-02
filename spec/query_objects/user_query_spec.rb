require 'rails_helper'

describe UserQuery do
  subject(:query) { described_class.new.search }

  before do
    @admin = create(:user, :admin)
    @member = create(:user, :member)
  end

  after do
    @admin.destroy
    @member.destroy
  end

  describe '#grouped_by_role' do
    it 'returns amount of member users' do
      expect(query.grouped_by_role(:member)).to eq(1)
    end

    it 'returns amount of admin users' do
      expect(query.grouped_by_role(:admin)).to eq(1)
    end
  end

  describe '#total_users' do
    it 'return total of users' do
      expect(query.total_users).to eq(2)
    end
  end
end

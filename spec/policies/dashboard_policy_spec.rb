require 'rails_helper'

RSpec.describe DashboardPolicy, type: :policy do
  subject { described_class }

  let(:member) { instance_double('User', admin?: false) }
  let(:admin) { instance_double('User', admin?: true) }

  permissions :index? do
    it { is_expected.to permit(admin) }
    it { is_expected.not_to permit(member) }
  end
end

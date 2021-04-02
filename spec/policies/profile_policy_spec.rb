require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  let(:member) { instance_double('User', admin?: false) }
  let(:admin) { instance_double('User', admin?: true) }

  permissions :show?, :edit?, :update? do
    it { is_expected.to permit(admin) }
    it { is_expected.to permit(member) }
  end
end

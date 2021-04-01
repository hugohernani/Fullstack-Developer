require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:member) { instance_double('User', admin?: false) }
  let(:admin) { instance_double('User', admin?: true) }

  permissions :index?, :new?, :edit?, :show?, :create?, :update?, :destroy? do
    it { is_expected.to permit(admin) }
    it { is_expected.not_to permit(member) }
  end

  permissions '.scope' do
    let(:user_scope) { instance_double('User::Scope', none: [], all: []) }

    before do
      stub_const('User', user_scope)
    end

    context 'with admin' do
      let(:scope_policy){ described_class::Scope.new(admin, user_scope) }

      it "calls for 'all' on User when allowed" do
        scope_policy.resolve

        expect(user_scope).to have_received(:all)
      end
    end

    context 'with member' do
      let(:scope_policy){ described_class::Scope.new(member, user_scope) }

      it 'calls for none on User when not allowed' do
        scope_policy.resolve

        expect(user_scope).to have_received(:none)
      end
    end
  end
end

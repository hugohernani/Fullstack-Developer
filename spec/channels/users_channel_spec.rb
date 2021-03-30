require 'rails_helper'

RSpec.describe UsersChannel do
  let!(:current_user) { create(:user) }

  it_behaves_like 'allowed logged in connection' do
    let(:logged_in_user) { current_user }
  end

  describe '#toggle_user_role' do
    let(:member_user) { instance_double('User', toggle_role: nil, id: 42) }

    before do
      mock_general_user_unrelated_comm(member_user)
      stub_connection current_user: current_user
      subscribe
    end

    it 'looks for User with received user_id payload' do
      perform :toggle_user_role, {
        user_id: member_user.id
      }

      expect(User).to have_received(:find).with(member_user.id)
    end

    it 'asks ApplicationController to render a partial' do
      perform :toggle_user_role, {
        user_id: member_user.id
      }

      expect(ApplicationController).to have_received(:renderer)
    end

    it 'receives broadcast call' do
      perform :toggle_user_role, {
        user_id: member_user.id
      }

      broadcast_expectation = { card_template: a_value, user_id: member_user.id }
      expect(described_class).to have_received(:broadcast_to).with(current_user, broadcast_expectation)
    end

    def mock_general_user_unrelated_comm(member_user)
      allow(User).to receive(:find).and_return(member_user)
      allow(ApplicationController).to receive_message_chain(:renderer, :render).and_return(nil)
      allow(described_class).to receive(:broadcast_to).and_return(nil)
    end
  end
end

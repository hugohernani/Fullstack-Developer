require 'rails_helper'

RSpec.describe 'Admin::Users' do
  let!(:user){ create(:user, :admin) }

  before do
    sign_in(user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get admin_user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_admin_user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:user) }

      it 'updates the requested profile' do
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.full_name).to eq new_attributes[:full_name]
      end

      it 'redirects to the profile' do
        patch admin_user_url(user), params: { user: new_attributes }
        expect(response).to redirect_to(admin_user_url(user))
      end
    end
  end
end

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

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_user_url(user)
      expect(response).to be_successful
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

      it 'updates the requested user' do
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.full_name).to eq new_attributes[:full_name]
      end

      it 'redirects to the user' do
        patch admin_user_url(user), params: { user: new_attributes }
        expect(response).to redirect_to(admin_user_url(user))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { attributes_for(:user, full_name: nil) }

      it 'does not update the requested user' do
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.full_name).not_to eq(new_attributes[:full_name])
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:user) }

      it 'updates the requested user' do
        post admin_users_url, params: { user: new_attributes }
        user = User.last
        user.reload
        expect(user.full_name).to eq new_attributes[:full_name]
        expect(user.role).to eq new_attributes[:role].to_s
      end

      it 'redirects to the users list' do
        post admin_users_url, params: { user: new_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { attributes_for(:user, email: nil) }

      it 'does not create an user' do
        expect do
          post admin_users_url, params: { user: new_attributes }
        end.not_to change(User, :count)
      end
    end
  end
end

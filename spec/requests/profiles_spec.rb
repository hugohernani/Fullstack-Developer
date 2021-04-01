require 'rails_helper'

RSpec.describe 'Profiles' do
  describe 'when user is an admin' do
    before do
      sign_in_as_admin
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get admin_profile_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        get admin_edit_profile_url
        expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { attributes_for(:user) }

        it 'updates the requested profile' do
          patch admin_profile_url, params: { user: new_attributes }
          @user.reload
          expect(@user.full_name).to eq new_attributes[:full_name]
        end

        it 'redirects to the profile' do
          patch admin_profile_url, params: { user: new_attributes }
          expect(response).to redirect_to(admin_profile_url)
        end
      end

      context 'with invalid parameters' do
        let(:new_attributes) { attributes_for(:user, full_name: nil) }

        it 'does not update the requested user' do
          patch admin_profile_url, params: { user: new_attributes }
          @user.reload
          expect(@user.full_name).not_to eq(new_attributes[:full_name])
        end
      end
    end
  end

  describe 'when user is a member' do
    before do
      sign_in_as_member
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get profile_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        get edit_profile_url
        expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { attributes_for(:user) }

        it 'updates the requested profile' do
          patch profile_url, params: { user: new_attributes }
          @user.reload
          expect(@user.full_name).to eq new_attributes[:full_name]
        end

        it 'redirects to the profile' do
          patch profile_url, params: { user: new_attributes }
          expect(response).to redirect_to(profile_url)
        end
      end
    end
  end
end

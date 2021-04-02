require 'rails_helper'

RSpec.describe 'Admin::Users::Bulks', type: :request do
  let!(:user){ create(:user, :admin) }

  before do
    sign_in(user)
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/users/bulk/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let!(:bulk_upload){ create(:bulk_upload, uploader: user) }

    it 'returns http success' do
      get "/admin/users/bulk/#{bulk_upload.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:file) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/user-bulk.xlsx'),
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      )
    end

    let(:bulk_params) do
      {
        file: file
      }
    end

    it 'returns http success' do
      post '/admin/users/bulk', params: { bulk_upload: bulk_params }
      expect(response).to have_http_status(:redirect)
    end
  end
end

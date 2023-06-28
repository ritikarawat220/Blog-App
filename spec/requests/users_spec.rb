require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success and renders the index template' do
      get '/users/index'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/index'
      expect(response.body).to match(/All users will be displayed/)
    end
  end

  describe 'GET /show' do
    it 'returns http success and renders the show template' do
      get '/users/show'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/show'
      expect(response.body).to match(/Single user will be displayed/)
    end
  end
end

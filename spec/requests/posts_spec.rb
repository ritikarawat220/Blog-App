require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success and renders the index template' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:user_id/posts'
      expect(response.body).to match('Here is a list of posts and comments for a given user')
    end
  end

  describe 'GET /show' do
    it 'returns http success and renders the show template' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to match('Here is a post and its list of comments')
    end
  end
end

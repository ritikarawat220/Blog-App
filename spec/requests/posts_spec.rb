require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe') }

    before do
      Post.create(title: 'Post 1', body: 'Lorem ipsum', author: user)
      Post.create(title: 'Post 2', body: 'Dolor sit amet', author: user)
      Post.create(title: 'Post 3', body: 'Consectetur adipiscing elit', author: user)
    end

    it 'returns http success and renders the index template' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe') }
    let(:post) { Post.create(title: 'Post 1', body: 'Lorem ipsum', author: user) }

    it 'returns http success and renders the show template' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(name: 'Ritika', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
    end
    let(:post) do
      Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    it 'Must have a title' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'Invalid if more than 250 characters' do
      post.title = 's' * 251
      expect(post).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      post.likes_counter = 0.5
      expect(post).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      post.comments_counter = -5
      expect(post).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      post.comments_counter = 0.7
      expect(post).to_not be_valid
    end

    describe 'Post counter' do
      it 'should belong to the correct user' do
        expect(post.author).to eql user
      end

      it 'should update counter of related user' do
        expect { post.send(:update_user_posts_counter) }.to change { user.reload.posts_counter }.by(1)
      end
    end

    describe '#recent_comments' do
      let(:user) do
        User.create(name: 'Ritika', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
      end
      let(:post) do
        Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                    likes_counter: 0)
      end

      it 'returns an empty array if there are no comments' do
        recent_comments = post.recent_comments

        expect(recent_comments).to be_empty
      end
    end
  end
end

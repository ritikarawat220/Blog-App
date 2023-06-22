require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(name: 'Ritika', photo: 'Image will be displayed here', bio: 'Hello pals', posts_counter: 0)
    end
    let(:post) do
      Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    subject(:comment) do
      described_class.create(text: 'This is my first comment', post:, author: user)
    end

    it 'is valid without text' do
      subject.text = nil
      expect(subject).to be_valid
    end

    it 'increments the comments counter of the associated post' do
      expect { comment.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end

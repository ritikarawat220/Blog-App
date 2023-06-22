require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(name: 'Ritika', photo: 'Image will be displayed here', bio: 'Hello guys', posts_counter: 0)
    end
    let(:post) do
      Post.create(title: 'First Post', text: 'This is my first post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    subject(:like) do
      described_class.new(author: user, post:)
    end

    it 'requires a user id' do
      subject.author_id = nil
      expect(subject).to_not be_valid
    end

    it 'requires a post id' do
      subject.post_id = nil
      expect(subject).to_not be_valid
    end

    it 'increments the likes counter of the associated post' do
      expect do
        subject.save
        post.reload
      end.to change { post.likes_counter }.by(1)
    end
  end
end

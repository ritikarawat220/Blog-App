require 'rails_helper'

RSpec.describe 'Post #Show Page', type: :feature do
  let(:user) do
    User.create(name: 'Lilly', photo: 'https://example.jpg',
                bio: 'She is a teacher from Mexico', posts_counter: 10)
  end

  let(:post) do
    Post.create!(id: 1, author: user, title: 'test post', text: 'This is my first post',
                 body: 'This is the body of the post', likes_counter: 15, comments_counter: 10)
  end  

  let(:comment) do
    Comment.create(post: post, author: user, text: 'test comment')
  end   

  before(:each) do
    visit user_post_path(user_id: user.id, id: post.id)
  end

  it 'I can see the post\'s title.' do
    expect(page).to have_content(post.title)
  end

  it 'I can see who wrote the post.' do
    expect(page).to have_content(post.author.name)
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content("Comments: 0")
  end

  it 'I can see how many likes it has.' do
    expect(page).to have_content("Likes: 0")
  end

  it 'I can see the post body.' do
    expect(page).to have_content(post.text)
  end

  it 'I can see the username of each commenter.' do
    expect(page).to have_content(comment.author.name)
  end
end

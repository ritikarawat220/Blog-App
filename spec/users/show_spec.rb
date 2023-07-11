require 'rails_helper'

RSpec.describe 'User #Show Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Lilly', photo: 'https://example.jpg',
                        bio: 'She is a teacher from Mexico', posts_counter: 10)
    @post1 = Post.create(title: 'test post-1', text: 'test text-1', comments_counter: 1,
                         likes_counter: 2, author_id: @user.id)
    @post2 = Post.create(title: 'test post-2', text: 'test text-2', comments_counter: 1,
                         likes_counter: 2, author_id: @user.id)
    @post3 = Post.create(title: 'test post-3', text: 'test text-3', comments_counter: 1,
                         likes_counter: 2, author_id: @user.id)
    @post4 = Post.create(title: 'test post-4', text: 'test text-4', comments_counter: 1,
                         likes_counter: 2, author_id: @user.id)

    visit user_path(@user)
  end

  it 'I can see the user\'s profile picture.' do
    expect(page.html).to include(@user.photo)
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content(@user.name)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page.html).to have_content(@user.posts_counter)
  end

  it 'When I click to see all posts, it redirects me to the user\'s post index page.' do
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user))
  end

  it 'I can see the user\'s bio.' do
    expect(page).to have_content(@user.bio)
  end

  it 'I can see the user\'s first 3 posts.' do
    recent_posts = @user.posts.order(created_at: :desc).limit(3)
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user))
  end
end

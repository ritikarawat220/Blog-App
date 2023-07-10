require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.feature 'User show page' do
  scenario 'displays user profile picture, name, number of posts, bio, and first 3 posts' do
    user = User.create(name: 'John Doe', photo: 'www.unsplash.com/user/1', bio: 'Lorem ipsum')
    post1 = Post.create(author: user, text: 'First post')
    post2 = Post.create(author: user, text: 'Second post')
    post3 = Post.create(author: user, text: 'Third post')
    
    user.update(posts_counter: user.posts.count)

    visit user_path(user)

    expect(page).to have_selector("img[src='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
    expect(page).to have_content(user.bio)

    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
    expect(page).to have_content(post3.text)

    expect(page).not_to have_content('First post')
    expect(page).not_to have_content('Second post')
    expect(page).not_to have_content('Third post')

    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'clicking on a post redirects to that post\'s show page' do
    user = User.create(name: 'John Doe', photo: 'www.unsplash.com/user/1')
    post = Post.create(author: user, text: 'First post')

    visit user_path(user)
    click_link post.text, match: :first

    expect(current_path).to eq(post_path(post))
    expect(page).to have_content(post.text)
  end

  scenario 'clicking on "See all posts" redirects to the user\'s posts index page' do
    user = User.create(name: 'John Doe', photo: 'www.unsplash.com/user/1')

    visit user_path(user)
    click_link 'See all posts'

    expect(current_path).to eq(user_posts_path(user))
    expect(page).to have_content("Name: #{user.name}")
  end
end

require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.feature 'User index page' do
  scenario 'displays all users with their name, profile picture, and number of posts' do
    user1 = User.create(name: 'John Doe', photo: 'www.unsplash.com/user/1')
    user2 = User.create(name: 'Jane Doe', photo: 'www.unsplash.com/user/2')
    Post.create(author: user1)

    visit users_path

    expect(page).to have_content(user1.name)
    expect(page).to have_selector("img[src='#{user1.photo}']")
    expect(page).to have_content("Number of posts: #{user1.posts.count}")

    expect(page).to have_content(user2.name)
    expect(page).to have_selector("img[src='#{user2.photo}']")
    expect(page).to have_content("Number of posts: #{user2.posts.count}")
  end

  scenario 'clicking on a user redirects to that user\'s show page' do
    user = User.create(name: 'John Doe', photo: 'www.unsplash.com/user/1')

    visit users_path
    click_link user.name

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(user.name)
    expect(page).to have_selector("img[src='#{user.photo}']")
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end
end

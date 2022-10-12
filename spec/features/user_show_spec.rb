require 'rails_helper'

RSpec.describe 'users_show', type: :feature do
  before :each do
    # create user
    User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit user\'s bio', posts_counter: 0)

    # create posts
    Post.create(title: 'Title 1', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 2', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 3', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 4', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 5', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)

    visit user_url(User.first)
  end

  it "display user's username" do
    expect(page).to have_text('John Doe')
  end

  it 'has the number of posts the user has written' do
    expect(page).to have_text('Number of posts: 5')
  end

  it "displays user's bio" do
    expect(page).to have_content 'Lorem ipsum dolor sit user\'s bio'
  end

  it "displays user's first 3 posts" do
    expect(page).to have_content 'Title 1'
    expect(page).to have_content 'Title 2'
    expect(page).to have_content 'Title 3'
    expect(page).not_to have_content 'Title 4'
    expect(page).not_to have_content 'Title 5'
  end

  it 'has button to see all posts' do
    expect(page).to have_button 'See all posts'
    expect(page).to have_link 'See all post', href: user_posts_url(User.first)
  end

  it "button click redirect to user's posts index page" do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(User.first))
    expect(page).to have_link 'New Post', href: new_user_post_path(User.first)
    expect(page).to have_content 'Title 1'
    expect(page).to have_content 'Title 2'
    expect(page).to have_content 'Title 3'
    expect(page).to have_content 'Title 4'
    expect(page).to have_content 'Title 5'
  end
end

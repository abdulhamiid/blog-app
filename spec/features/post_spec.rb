require 'rails_helper'

RSpec.describe "posts/index.html.erb", type: :feature do
  before :each do
    # create use
    User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit user\'s bio', posts_counter: 0)
    
    # create posts
    Post.create(title: 'Capybara', text: 'Capybara helps you test web applications', author_id: User.first.id, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Title 2', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Title 3', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0, likes_counter: 0)

    # create comments
    Comment.create(text: 'This is the fist comment on capybara', post_id: Post.first.id, author_id: User.first.id)
    visit user_posts_path(User.first)
  end

  it "display user's username" do
    expect(page).to have_text('John Doe')
  end

  it "has the number of posts the user has written" do
    expect(page).to have_text 'Capybara'
    expect(page).to have_text 'Title 2'
    expect(page).to have_text 'Title 3'
  end

  it "has first comments on a post" do
    expect(page).to have_text 'Username: This is the fist comment on capybara'
  end

  it "has the posts text" do
    expect(page).to have_text 'Capybara helps you test web applications'
    expect(page).to have_text 'Lorem ipsum dolor sit'
  end

  it "has the number of comments and likes for each post" do
    expect(page).to have_text 'Comments: 1'
    expect(page).to have_text 'Comments: 0'
    expect(page).to have_text 'Likes: 0'
  end

  it "has pagination button section" do
    expect(page).to have_button 'Pagination'
  end

  it "button click redirect to user's posts index page" do
    expect(page).to have_link 'Capybara'
    click_link 'Capybara'
    expect(page).to have_current_path(user_post_path(User.first, Post.first))
  end
end
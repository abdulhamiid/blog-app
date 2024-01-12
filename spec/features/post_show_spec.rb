require 'rails_helper'

RSpec.describe 'posts_show', type: :feature do
  before :each do
    # create use
    User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit user\'s bio',
                photo: 'https://www.w3schools.com/howto/img_avatar.png', posts_counter: 0)

    # create posts
    Post.create(title: 'Capybara', text: 'Capybara helps you test web applications', author_id: User.first.id,
                comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Title 2', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Title 3', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0,
                likes_counter: 0)

    # create comments
    Comment.create(text: 'This is the fist comment on capybara', post_id: Post.first.id, author_id: User.first.id)
    visit user_post_path(User.first, Post.first)
  end

  it 'has the post title' do
    expect(page).to have_text('Capybara')
  end

  it 'has the post author' do
    expect(page).to have_text('Post by John Doe')
  end

  it 'has the post number of comments' do
    expect(page).to have_text('Comments: 1')
  end

  it 'has the post number of likes' do
    expect(page).to have_text('Likes: 0')
  end

  it 'has the post body' do
    expect(page).to have_text('Capybara helps you test web applications')
  end

  it 'has the username of each commenter' do
    expect(page).to have_text('John Doe:')
  end

  it 'has the username of each commenter' do
    expect(page).to have_text('John Doe: This is the fist comment on capybara')
  end

  it 'has a link to add a new comment' do
    expect(page).to have_link('Add a new comment')
  end

  it 'add a new comment link redirect to new comment page' do
    click_link('Add a new comment')
    expect(page).to have_current_path(new_user_post_comment_path(User.first, Post.first))
  end

  it 'has like post button' do
    expect(page).to have_button('Like post')
  end
end

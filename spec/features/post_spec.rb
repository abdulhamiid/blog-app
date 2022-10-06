require 'rails_helper'

RSpec.describe "posts", type: :feature do
  before :each do
    # create use
    User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit user\'s bio', photo: 'https://www.w3schools.com/howto/img_avatar.png', posts_counter: 0)
    
    # create posts
    Post.create(title: 'Capybara', text: 'Capybara helps you test web applications', author_id: User.first.id, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Title 2', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Title 3', text: 'Lorem ipsum dolor sit', author_id: User.first.id, comments_counter: 0, likes_counter: 0)

    # create comments
    Comment.create(text: 'This is the fist comment on capybara', post_id: Post.first.id, author_id: User.first.id)
  end

  # User post index page tests
  context "posts/index.html.erb" do
    before :each do
      visit user_posts_path(User.first)
    end

    it "displays user photo" do
      expect(page).to have_css("img[src*='https://www.w3schools.com/howto/img_avatar.png']")
    end

    it "display user's username" do
      expect(page).to have_text('John Doe')
    end

    it "has the number of posts the user has written" do
      expect(page).to have_text('Number of posts: 3')
    end

    it "has a post title" do
      expect(page).to have_text('Capybara')
    end

    it "has first comments on a post" do
      expect(page).to have_text 'John Doe: This is the fist comment on capybara'
    end

    it "has the number of comments and likes for a post" do
      expect(page).to have_text 'Comments: 1'
      expect(page).to have_text 'Comments: 0'
    end

    it "has pagination button section" do
      expect(page).to have_button 'Pagination'
    end

    it "button click redirect to user's posts index page" do
      expect(page).to have_link 'Capybara'
      click_link 'Capybara'
      expect(page).to have_current_path(user_post_path(User.first, Post.first))
    end

    it "has a link to new post page" do
      expect(page).to have_link 'New Post'
      click_link 'New Post'
      expect(page).to have_current_path(new_user_post_path(User.first))
    end
  end

  # User post show page tests
  context "posts/show.html.erb" do
    before :each do
      visit user_post_path(User.first, Post.first)
    end

    it "has the post title" do
      expect(page).to have_text('Capybara')
    end

    it "has the post author" do
      expect(page).to have_text('Post by John Doe')
    end

    it "has the post number of comments" do
      expect(page).to have_text('Comments: 1')
    end

    it "has the post number of likes" do
      expect(page).to have_text('Likes: 0')
    end

    it "has the post body" do
      expect(page).to have_text('Capybara helps you test web applications')
    end

    it "has the username of each commenter" do
      expect(page).to have_text('John Doe:')
    end

    it "has the username of each commenter" do
      expect(page).to have_text('John Doe: This is the fist comment on capybara')
    end

    it "has a link to add a new comment" do
      expect(page).to have_link('Add a new comment')
    end

    it "add a new comment link redirect to new comment page" do
      click_link('Add a new comment')
      expect(page).to have_current_path(new_user_post_comment_path(User.first, Post.first))
    end

    it "has like post button" do
      expect(page).to have_button('Like post')
    end
  end
end
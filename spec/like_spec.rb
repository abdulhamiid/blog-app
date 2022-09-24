require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      photo: 'https://unsplash.com/box.jpg',
      bio: 'Engineer',
      posts_counter: 0
    )
    @post = Post.create(
      # new title
      title: 'Blog App',
      text: 'Ruby on Rails',
      author_id: @user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it '@posts like_counter should increase by one' do
    Like.create(author_id: @user.id, post_id: @post.id)
    Like.create(author_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.likes_counter).to eq(2)
  end
end

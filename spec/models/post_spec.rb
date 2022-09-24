require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0)
    @user = User.create(name: 'Peter', photo: 'https://unsplash.com/box.jpg', bio: 'Engineer', posts_counter: 0)
  end

  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should not be too long' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be present' do
    @post.comments_counter = nil
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    @post.comments_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be present' do
    @post.likes_counter = nil
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    @post.likes_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'should belong to author' do
    assc = described_class.reflect_on_association(:author)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should have many likes' do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many comments' do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
  end
end

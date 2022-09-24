require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Title', author_id: 1, comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not be too long' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be present' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be present' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
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

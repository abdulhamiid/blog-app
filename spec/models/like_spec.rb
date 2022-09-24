require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(user_id: 1, post_id: 1) }

  before { subject.save }

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'post_id should be present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should belong to user' do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should belong to post' do
    assc = described_class.reflect_on_association(:post)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should update post likes_counter' do
    subject.update_likes_counter
    expect(subject.post.likes_counter).to eq 1
  end
end
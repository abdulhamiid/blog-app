require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(user_id: 1, post_id: 1, text: 'Lorem ipsum') }

  before { subject.save }

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'post_id should be present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  it 'content should be a string' do
    subject.text = 1
    expect(subject).to_not be_valid
  end

  it 'content should be at least 1 character long' do
    subject.content = ''
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

  it 'should update post comments_counter' do
    subject.update_counter
    expect(subject.post.comments_counter).to eq 1
  end
end
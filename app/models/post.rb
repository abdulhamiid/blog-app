# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: true
  validates :likes_counter, numericality: true

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    comments.order('created_at Desc').last(5)
  end
end

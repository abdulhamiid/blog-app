class User < ApplicationRecord
  ROLES = %w[user admin].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy, foreign_key: 'author_id'
  has_many :comments, dependent: :destroy, foreign_key: 'author_id'
  has_many :likes, dependent: :destroy, foreign_key: 'author_id'
  has_one_attached :user_image

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  after_validation do
    puts "USER VALIDATION ERRORS: #{errors.full_messages.inspect}"
  end
  def recent_posts
    posts.order('created_at Desc').last(3)
  end
end

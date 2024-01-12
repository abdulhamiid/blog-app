# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :photo, :role, :posts_counter
  has_many :posts
end

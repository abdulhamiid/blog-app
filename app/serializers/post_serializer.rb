# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :comments_counter
  has_many :likes
  has_many :comments
end

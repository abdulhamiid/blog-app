class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :comments_counter
  belongs_to :user
end

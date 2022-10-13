class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :comments_counter
end

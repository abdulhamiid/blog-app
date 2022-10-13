class LikeSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :post
end

# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text
end

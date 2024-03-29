# frozen_string_literal: true

class AddPostsRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :post, null: false, foreign_key: true, index: true
  end
end

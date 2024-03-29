# frozen_string_literal: true

class AddUsersRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, null: false, foreign_key: true, index: true
  end
end

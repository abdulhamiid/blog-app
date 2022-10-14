# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
    else
      can :destroy, Post do |post|
        post.author == user
      end
      can :destroy, Comment do |post|
        post.comment == user
      end

      can :create, Post
      can :create, Comment
    end
  end
end

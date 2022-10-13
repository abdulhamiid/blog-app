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

      can :create, Post
    end
  end
end

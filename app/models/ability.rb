# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    can :create, Restaurant if user.user_restaurant?
    can :destroy, Restaurant, user: user if user.user_restaurant?
    can :update, Restaurant, user: user if user.user_restaurant?
    can :read, Restaurant if user.user_restaurant?
    can :read, Product if user.user_restaurant?
    can %i[create update], OrderItem if user.user_restaurant?
    cannot %i[create update destroy], Product if user.user_restaurant?
    cannot %i[create update destroy], Brand if user.user_restaurant?

  end
end

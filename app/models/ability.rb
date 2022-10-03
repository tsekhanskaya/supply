# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin

    can :read, Restaurant if user.user_restaurant
    can :create, Restaurant if user.user_restaurant
    can :update, Restaurant, user: user if user.user_restaurant
    can :destroy, Restaurant, user: user if user.user_restaurant
    can :read, Product if user.user_restaurant
    can %i[create update], OrderItem if user.user_restaurant
    cannot %i[create update destroy], Product if user.user_restaurant
    cannot %i[create update destroy], Brand if user.user_restaurant

    can :read, Brand if user.user_brand
    can :create, Brand if user.user_brand
    can :update, Brand if user.user_brand
    can :destroy, Brand, user: user if user.user_brand
    can %i[create update destroy read], Product if user.user_brand
    can :update, OrderItem if user.user_brand
    can :read, Restaurant if user.user_brand
    cannot %i[create update destroy], Restaurant if user.user_restaurant

    # can :create, Restaurant if user.user_restaurant?
    # can :destroy, Restaurant, user: user if user.user_restaurant?
    # can :update, Restaurant, user: user if user.user_restaurant?
    # can :show, Restaurant if user.user_restaurant?
    # can :read, Restaurant if user.user_restaurant?
    # can :read, Product if user.user_restaurant?
    # can %i[create update], OrderItem if user.user_restaurant?
    # cannot %i[create update destroy], Product if user.user_restaurant?
    # cannot %i[create update destroy], Brand if user.user_restaurant?
  end
end

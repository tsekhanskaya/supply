# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin

    can %i[read create update destroy], Restaurant if user.user_restaurant
    can :read, Product if user.user_restaurant
    can :read, OrderItem if user.user_restaurant
    can :create, OrderItem if user.user_restaurant
    can :update, OrderItem, user: user if user.user_restaurant
    can :destroy, OrderItem, user: user if user.user_restaurant
    cannot %i[create update destroy], Product if user.user_restaurant

    can %i[create update read destroy], Brand if user.user_brand
    can %i[create update destroy read], Product if user.user_brand
    can :update, OrderItem if user.user_brand
    can :read, Restaurant if user.user_brand
  end
end

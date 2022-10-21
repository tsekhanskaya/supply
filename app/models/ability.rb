# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin

    can %i[read create], Restaurant if user.user_restaurant
    can %i[update destroy], Restaurant.where(user_id: user.id) if user.user_restaurant
    can :read, Product if user.user_restaurant
    can :read, OrderItem if user.user_restaurant
    can :create, OrderItem if user.user_restaurant
    can :update, OrderItem, user: user if user.user_restaurant
    can :destroy, OrderItem, user: user if user.user_restaurant
    cannot %i[create update destroy], Product if user.user_restaurant

    can %i[read create], Brand if user.user_brand
    can %i[update destroy], Brand.where(user_id: user.id) if user.user_brand
    can %i[read create], Product if user.user_brand
    can %i[update destroy], Product if user.user_brand
    # can %i[update destroy], current_user.brands.products if user.user_brand
    can %i[update destroy], user.brands.products if user.user_brand
    can :update, OrderItem if user.user_brand
    can :read, Restaurant if user.user_brand
  end
end

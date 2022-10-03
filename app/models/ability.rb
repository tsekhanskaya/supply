# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin

    can %i[create read], Restaurant if user.user_restaurant
    can %i[update destroy], Restaurant, user: user.user_restaurant if user.user_restaurant
    can :read, Product if user.user_restaurant
    can [:create, :update], OrderItem if user.user_restaurant
    cannot %i[create update destroy], Product if user.user_restaurant
    cannot %i[create update destroy], Brand if user.user_restaurant

    can %i[read create], Brand if user.user_brand
    can %i[update destroy], Brand, user: user.user_brand if user.user_brand
    can %i[create update destroy read], Product if user.user_brand
    can %i[update], OrderItem if user.user_brand
    can :read, Restaurant if user.user_brand
    cannot %i[create update destroy], Restaurant if user.user_restaurant
  end
end

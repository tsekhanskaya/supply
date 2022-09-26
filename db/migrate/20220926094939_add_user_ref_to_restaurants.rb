# frozen_string_literal: true

class AddUserRefToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_reference :restaurants, :user, foreign_key: false
  end
end

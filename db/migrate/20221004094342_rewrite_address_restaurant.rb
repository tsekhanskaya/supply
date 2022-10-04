# frozen_string_literal: true

class RewriteAddressRestaurant < ActiveRecord::Migration[7.0]
  def change
    remove_column :restaurants, :address, :string

    add_column :restaurants, :street, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :state, :string
    add_column :restaurants, :country, :string
  end
end

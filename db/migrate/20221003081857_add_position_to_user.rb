class AddPositionToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_restaurant, :boolean, default: true
    add_column :users, :user_brand, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end

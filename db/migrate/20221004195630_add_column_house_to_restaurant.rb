class AddColumnHouseToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :house, :string
  end
end

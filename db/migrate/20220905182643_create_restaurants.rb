class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :img, default: 'no_image.jpg'

      t.timestamps
    end
  end
end

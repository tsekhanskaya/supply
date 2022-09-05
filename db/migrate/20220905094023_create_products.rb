# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :brand_id
      t.string :title, default: 'No title'
      t.float :price, default: 0
      t.text :description, default: 'No description'
      t.string :img, default: 'no_image.jpg'

      t.timestamps
    end
  end
end

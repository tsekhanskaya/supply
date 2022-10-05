# frozen_string_literal: true

class ChangeColumnsToBrand < ActiveRecord::Migration[7.0]
  def change
    change_table :brands do |t|
      t.remove :address

      t.string :house
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
    end
  end
end

# frozen_string_literal: true

class AddContactsToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :contacts, :string
  end
end

# frozen_string_literal: true

class AddCategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category, foreign_key: true
  end
end

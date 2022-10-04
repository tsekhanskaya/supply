# frozen_string_literal: true

class AddUserRefToBrands < ActiveRecord::Migration[7.0]
  def change
    add_reference :brands, :user, foreign_key: false
  end
end

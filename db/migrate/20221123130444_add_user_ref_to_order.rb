# frozen_string_literal: true

class AddUserRefToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end

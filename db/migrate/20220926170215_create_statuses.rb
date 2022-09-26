# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :statuses do |t|
      t.integer :number
      t.string :title
      t.timestamps
    end
  end
end

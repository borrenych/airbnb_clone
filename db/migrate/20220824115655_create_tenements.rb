# frozen_string_literal: true

class CreateTenements < ActiveRecord::Migration[6.1]
  def change
    create_table :tenements do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :guests
      t.string :region
      t.references :user, null: false, foreign_key: true
      t.references :property_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :tenement, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :arrive
      t.date :departure

      t.timestamps
    end
  end
end

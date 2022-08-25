# frozen_string_literal: true

class Tenement < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :title, :description, :price, :guests, :region, :property_type, :user_id, presence: true

  enum property_type: %w[House Apartment Guesthouse Hotel]

  scope :filter_by_price, ->(price) { where('price <= ?', price) }
  scope :filter_by_guests, ->(guests) { where('guests >= ?', guests) }
  scope :filter_by_property_type, ->(property_type) { where(property_type: property_type) }
  scope :filter_by_region, ->(region) { where('region LIKE ?', "%#{region}%") }
  scope :with_no_bookings, -> { where(bookings: { id: nil }) }

  scope :not_reserved, ->(reserved_tenement_id) { where.not(bookings: { tenement_id: reserved_tenement_id }).group(:id) }
end

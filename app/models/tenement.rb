class Tenement < ApplicationRecord
  belongs_to :property_type
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :title, :description, :price, :guests, :region, :property_type_id, :user_id, presence: true

  scope :filter_by_price, ->(price) { where('price <= ?', price) }
  scope :filter_by_guests, ->(guests) { where('guests >= ?', guests) }
  scope :filter_by_property_type_id, ->(property_type_id) { where(property_type_id: property_type_id) }
  scope :filter_by_region, ->(region) { where('region LIKE ?', "%#{region}%") }
  scope :with_no_bookings, -> { where(bookings: { id: nil }) }

  scope :booked, lambda { |arrive, departure|
    arrive_inside(arrive).or(departure_inside(departure)).or(arrive_departure_outside(arrive, departure)).pluck(:id)
  }
  scope :not_reserved, ->(reserved_tenement_id) { where.not(bookings: { tenement_id: reserved_tenement_id }) }
  scope :arrive_inside, lambda { |arrive|
    where('arrive <= ? AND departure >= ?', arrive, arrive).group(:id)
  }
  scope :departure_inside, lambda { |departure|
    where('arrive <= ? AND departure >= ?', departure, departure).group(:id)
  }
  scope :arrive_departure_outside, lambda { |arrive, departure|
    where('arrive >= ? AND departure <= ?', arrive, departure).group(:id)
  }
end

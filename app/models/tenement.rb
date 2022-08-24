class Tenement < ApplicationRecord
  belongs_to :property_type
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :title, :description, :price, :guests, :region, :property_type_id, :user_id, presence: true
end

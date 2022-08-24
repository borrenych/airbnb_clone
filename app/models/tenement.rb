class Tenement < ApplicationRecord
  belongs_to :property_type
  has_many :bookings, dependent: :destroy
  belongs_to :user
end

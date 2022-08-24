class Booking < ApplicationRecord
  belongs_to :tenement
  belongs_to :user
end

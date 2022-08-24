class Booking < ApplicationRecord
  belongs_to :tenement
  belongs_to :user
  validates :arrive, :departure, presence: true
  validate :no_past_booking
  validate :departure_after_arrive
  validate :already_reserved

  def no_past_booking
    errors.add(:Booking, 'cannot be in the past') if Date.today > arrive.to_date
  end

  def departure_after_arrive
    errors.add(:departure, 'must be after the arrive date') if departure < arrive
  end

  def already_reserved
    bookings = Booking.where(tenement_id: tenement_id)
    date_ranges = bookings.map { |booking| booking.arrive..booking.departure }

    date_ranges.each do |range|
      errors.add(:tenement, 'already reserved by another') if range.include?(arrive) || range.include?(departure)
    end
  end
end

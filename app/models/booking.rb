# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :tenement
  belongs_to :user
  validates :arrive, :departure, presence: true
  validate :no_past_booking, on: :create
  validate :departure_after_arrive
  validate :already_reserved

  def no_past_booking
    errors.add(:Booking, 'cannot be in the past') if Date.today > arrive.to_date
  end

  def departure_after_arrive
    errors.add(:departure, 'must be after the arrive date') if departure < arrive
  end

  def already_reserved
    booking_range = arrive..departure
    date_ranges = tenement.bookings.map { |booking| booking.arrive..booking.departure }

    date_ranges.each do |range|
      if range.include?(arrive) || range.include?(departure) || range.in?(booking_range)
        errors.add(:tenement, 'already reserved by another')
      end
    end
  end

  scope :booked, lambda { |arrive, departure|
    arrive_inside(arrive).or(departure_inside(departure)).or(arrive_departure_outside(arrive, departure))
  }
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

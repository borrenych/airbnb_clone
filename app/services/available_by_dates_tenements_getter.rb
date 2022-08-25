# frozen_string_literal: true

module AvailableByDatesTenementsGetter
  module_function

  def call(tenements, arrive, departure)
    tenements = tenements.left_joins(:bookings)
    reserved_tenements = Booking.booked(arrive, departure).pluck(:tenement_id)
    tenements.not_reserved(reserved_tenements).or(tenements.with_no_bookings).sort
  end
end


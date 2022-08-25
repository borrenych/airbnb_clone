# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def create
    @booking = current_user.bookings.new(booking_params)

    redirect_to tenement_path(@booking.tenement_id), notice: 'Success' and return if @booking.save

    redirect_to tenement_path(@booking.tenement_id), alert: @booking.errors
  end

  def destroy
    booking = current_user.bookings.find(params[:id])
    booking.destroy

    redirect_to bookings_url, notice: booking.errors.first || 'Success'
  end

  private

  def booking_params
    params.require(:booking).permit(:arrive, :departure, :tenement_id)
  end
end

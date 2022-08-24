# frozen_string_literal: true

class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    redirect_to tenement_path(@booking.tenement_id), notice: 'Success' and return if @booking.save

    redirect_to tenement_path(@booking.tenement_id), alert: @booking.errors
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy if booking.user_id == current_user.id

    redirect_to bookings_url, notice: booking.errors.first || 'Success'
  end

  private

  def booking_params
    params.require(:booking).permit(:arrive, :departure, :tenement_id, :user_id)
  end
end

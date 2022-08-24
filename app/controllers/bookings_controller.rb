# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    redirect_to tenement_path(@booking.tenement_id), notice: 'Success' and return if @booking.save

    redirect_to tenement_path(@booking.tenement_id), alert: @booking.errors
  end

  private

  def booking_params
    params.require(:booking).permit(:arrive, :departure, :tenement_id, :user_id)
  end
end
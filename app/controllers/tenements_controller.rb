# frozen_string_literal: true

class TenementsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def index
    @tenements = TenementsSearcher.call(filtering_params)
    return unless params[:arrive].present? && params[:departure].present?

    @tenements = AvailableByDatesTenementsGetter.call(@tenements, params[:arrive],
                                                      params[:departure])
  end

  def show
    @tenement = Tenement.find(params[:id])
    @booking = Booking.new(tenement: @tenement)
  end

  private

  def filtering_params
    params.permit(:price, :guests, :property_type, :region)
  end
end

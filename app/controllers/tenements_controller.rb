# frozen_string_literal: true

class TenementsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :property_types, only: %i[index]

  def index
    @tenements = TenementsSearcher.call(Tenement.all, filtering_params)
    if params[:arrive].present? && params[:departure].present?
      @tenements = AvailableByDatesTenementsGetter.call(@tenements, params[:arrive],
                                                        params[:departure])
    end
  end

  def show
    @tenement = Tenement.find(params[:id])
    @booking = Booking.new(tenement: @tenement)
  end

  private

  def property_types
    @property_types = Tenement.property_types
  end

  def filtering_params
    params.permit(:price, :guests, :property_type, :region)
  end
end

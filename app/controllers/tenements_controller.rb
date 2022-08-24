# frozen_string_literal: true

class TenementsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :property_types, only: %i[index]

  def index
    @tenements = Tenement.all
    filtering_params(params).each do |key, value|
      @tenements = @tenements.public_send("filter_by_#{key}", value) if value.present?
    end
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
    @types = PropertyType.all.pluck(:name, :id)
  end

  def filtering_params(params)
    params.slice(:price, :guests, :property_type_id, :region)
  end
end

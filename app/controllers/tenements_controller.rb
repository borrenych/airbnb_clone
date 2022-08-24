# frozen_string_literal: true

class TenementsController < ApplicationController
  before_action :authenticate_user!
  before_action :property_types, only: %i[index new]

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

  def new
    @tenement = Tenement.new
  end

  def create
    @tenement = Tenement.new(tenements_params)
    @tenement.user_id = current_user.id
    redirect_to tenements_path, notice: 'Success' and return if @tenement.save

    redirect_to new_tenement_path, alert: @tenement.errors
  end

  def show
    @tenement = Tenement.find(params[:id])
    @booking = Booking.new(tenement: @tenement)
  end

  private

  def property_types
    @types = PropertyType.all.pluck(:name, :id)
  end

  def tenements_params
    params.require(:tenement).permit(:title, :description, :price, :guests, :region, :property_type_id, :user_id)
  end

  def filtering_params(params)
    params.slice(:price, :guests, :property_type_id, :region)
  end
end
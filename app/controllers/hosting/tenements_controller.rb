# frozen_string_literal: true

module Hosting
  class TenementsController < ApplicationController
    before_action :authenticate_user!
    before_action :property_types, only: %i[index new create]

    def index
      @tenements = Tenement.where(user_id: current_user.id)
    end

    def new
      @tenement = Tenement.new
    end

    def create
      @tenement = Tenement.new(tenements_params)
      @tenement.user_id = current_user.id
      redirect_to hosting_tenements_path, notice: 'Success' and return if @tenement.save

      redirect_to new_hosting_tenement_path, alert: @tenement.errors
    end

    def show
      @tenement = Tenement.find(params[:id])
      @bookings = Booking.where(tenement_id: @tenement.id)
    end

    def destroy
      tenement = Tenement.find(params[:id])
      tenement.destroy if tenement.user_id == current_user.id

      redirect_to hosting_tenements_path, notice: tenement.errors.first || 'Success'
    end

    private

    def property_types
      @types = PropertyType.all.pluck(:name, :id)
    end

    def tenements_params
      params.require(:tenement).permit(:title, :description, :price, :guests, :region, :property_type_id, :user_id)
    end
  end
end

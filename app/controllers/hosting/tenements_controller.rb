# frozen_string_literal: true

module Hosting
  class TenementsController < ApplicationController
    before_action :authenticate_user!

    def index
      @tenements = current_user.tenements
    end

    def new
      @tenement = Tenement.new
    end

    def create
      @tenement = current_user.tenements.new(tenements_params)

      redirect_to hosting_tenements_path, notice: 'Success' and return if @tenement.save

      redirect_to new_hosting_tenement_path, alert: @tenement.errors
    end

    def show
      @tenement = Tenement.find(params[:id])
      @bookings = Booking.where(tenement_id: @tenement.id)
    end

    def destroy
      tenement = current_user.tenements.find(params[:id])
      tenement.destroy

      redirect_to hosting_tenements_path, notice: tenement.errors.first || 'Success'
    end

    private

    def tenements_params
      params.require(:tenement).permit(:title, :description, :price, :guests, :region, :property_type)
    end
  end
end

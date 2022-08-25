# frozen_string_literal: true

module TenementsSearcher
  module_function

  def call(params, tenements = Tenement.all)
    tenements = tenements.filter_by_price(params[:price]) if params[:price].present?
    tenements = tenements.filter_by_guests(params[:guests]) if params[:guests].present?
    tenements = tenements.filter_by_property_type(params[:property_type]) if params[:property_type].present?
    tenements = tenements.filter_by_region(params[:region]) if params[:region].present?
    tenements
  end
end

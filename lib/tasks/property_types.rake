# frozen_string_literal: true

namespace :property_types do
  task create: :environment do
    PropertyType.create(name: 'House')
    PropertyType.create(name: 'Apartment')
    PropertyType.create(name: 'Guesthouse')
    PropertyType.create(name: 'Hotel')
  end
end
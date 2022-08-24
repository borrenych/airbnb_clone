# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  context 'departure_after_arrive' do
    it 'returns false' do
      expect(Booking.new(id: 2, departure: Date.today, arrive: Date.today + 1).save).to eq(false)
    end
  end

  context 'no_past_booking' do
    it 'returns false' do
      expect(Booking.new(id: 3, arrive: Date.yesterday, departure: Date.today).save).to eq(false)
    end
  end
end
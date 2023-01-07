# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenement, type: :model do
  context 'no title' do
    it 'returns false' do
      expect(Tenement.new(description: "description", price: 120, guests: 3, region: "region").save).to eq(false)
    end
  end

  context 'no description' do
    it 'returns false' do
      expect(Tenement.new(title: "title", price: 120, guests: 3, region: "region").save).to eq(false)
    end
  end

  context 'no price' do
    it 'returns false' do
      expect(Tenement.new(title: "title", description: "description", guests: 3, region: "region").save).to eq(false)
    end
  end

  context 'no region' do
    it 'returns false' do
      expect(Tenement.new(title: "title", description: "description", price: 120, guests: 3).save).to eq(false)
    end
  end
end
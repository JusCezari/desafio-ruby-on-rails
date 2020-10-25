# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cnab::CnabRecord do
  context 'when creating with a text constructor' do
    it 'should have attribute text with the value passed in the construct' do
      text = Faker::Movies::StarWars.quote
      cnab = Cnab::CnabRecord.new(text)
      expect(cnab.text).to eq(text)
    end
  end
end

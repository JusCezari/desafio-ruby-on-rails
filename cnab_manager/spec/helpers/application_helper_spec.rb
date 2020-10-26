# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  context 'inner methods' do
    context '#value_as_money' do
      it 'should return the value with the R$ as prefix' do
        expect(value_as_money(100)).to eq('R$ 100,00')
        expect(value_as_money(10000)).to eq('R$ 10.000,00')
        expect(value_as_money(-200)).to eq('-R$ 200,00')
        expect(value_as_money(-20000)).to eq('-R$ 20.000,00')
      end
    end
    
    context '#date_br' do
      it 'should return a UTC date converted to BRT time' do
        time_to_use = Time.now.utc
        expect(date_br(time_to_use)).to eq(time_to_use.in_time_zone('Brasilia').strftime('%d/%m/%Y %H:%M'))
      end
    end
  end
end
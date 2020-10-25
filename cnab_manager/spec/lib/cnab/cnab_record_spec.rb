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

  context 'when extracting data from the text' do
    before :context do
      # Setting a fixed example following what we received as the documentation
      @ex_type = '1'
      @ex_date = '20201025'
      @ex_value = '0000012345'
      @ex_normalized_value = 123.45
      @ex_cpf = 'DDDDDDDDDDD'
      @ex_card = 'EEEEEEEEEEEE'
      @ex_hour = '020304'
      @ex_parsed_time = Time.new(2020, 10, 25, 2, 3, 4, '-03:00')
      @ex_owner = 'GGGGGGGGGGGGGG'
      @ex_store = 'HHHHHHHHHHHHHHHHHH'
      # We will use this example to compare in the tests below
      ex_text = "#{@ex_type}#{@ex_date}#{@ex_value}#{@ex_cpf}#{@ex_card}#{@ex_hour}#{@ex_owner}#{@ex_store}"
      @ex_cnab = Cnab::CnabRecord.new(ex_text)
    end

    before :example do
      # Generate a new random CNAB to use in every example
      @random_cnab = build(:cnab_record)
    end

    it 'should get transaction type from the first character as integer' do
      expect(@random_cnab.transaction_type).to eq(@random_cnab.text[0])
      expect(@ex_cnab.transaction_type).to eq(@ex_type)
    end

    it 'should get date from characters between positions 1 and 8' do
      expect(@random_cnab.date).to eq(@random_cnab.text[1..8])
      expect(@ex_cnab.date).to eq(@ex_date)
    end

    it 'should get value from characters between positions 9 and 18' do
      expect(@random_cnab.value).to eq(@random_cnab.text[9..18])
      expect(@ex_cnab.value).to eq(@ex_value)
    end

    it 'should get cpf from characters between positions 19 and 29' do
      expect(@random_cnab.cpf).to eq(@random_cnab.text[19..29])
      expect(@ex_cnab.cpf).to eq(@ex_cpf)
    end

    it 'should get card number from characters between positions 30 and 41' do
      expect(@random_cnab.card_number).to eq(@random_cnab.text[30..41])
      expect(@ex_cnab.card_number).to eq(@ex_card)
    end

    it 'should get hour from characters between positions 42 and 47' do
      expect(@random_cnab.hour).to eq(@random_cnab.text[42..47])
      expect(@ex_cnab.hour).to eq(@ex_hour)
    end

    it 'should get owner name from characters between positions 48 and 61 and strip it' do
      expect(@random_cnab.owner_name).to eq(@random_cnab.text[48..61].strip)
      expect(@ex_cnab.owner_name).to eq(@ex_owner)
    end

    it 'should get store name from characters between positions 62 and 80 and strip it' do
      expect(@random_cnab.store_name).to eq(@random_cnab.text[62..80].strip)
      expect(@ex_cnab.store_name).to eq(@ex_store)
    end

    context 'when data need normalization' do
      it 'should use date and hour to generate a parsed time' do
        expect(@random_cnab.parsed_time).to eq(Time.parse("#{@random_cnab.date}#{@random_cnab.hour}"))
        expect(@ex_cnab.parsed_time).to eq(@ex_parsed_time)
      end

      it 'should normalize the value dividing by 100' do
        expect(@random_cnab.normalized_value).to eq(@random_cnab.value.to_f / 100)
        expect(@ex_cnab.normalized_value).to eq(@ex_normalized_value)
      end
    end

    context 'when need to export data to generate another object' do
      it 'should return a hash to use to create a Transaction object' do
        expect(@random_cnab.hash_for_transaction).to eq({
                                                          transaction_type: @random_cnab.transaction_type.to_i,
                                                          date: @random_cnab.parsed_time,
                                                          value: @random_cnab.normalized_value,
                                                          cpf: @random_cnab.cpf,
                                                          card_number: @random_cnab.card_number
                                                        })
        expect(@ex_cnab.hash_for_transaction).to eq({
                                                      transaction_type: @ex_cnab.transaction_type.to_i,
                                                      date: @ex_cnab.parsed_time,
                                                      value: @ex_cnab.normalized_value,
                                                      cpf: @ex_cnab.cpf,
                                                      card_number: @ex_cnab.card_number
                                                    })
      end
    end
  end
end

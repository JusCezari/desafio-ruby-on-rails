# frozen_string_literal: true

module Cnab
  # Class to represent a registry read from a CNAB file
  class CnabRecord
    attr_accessor :text

    def initialize(text)
      self.text = text
    end

    def transaction_type
      text[0]
    end

    def date
      text[1..8]
    end

    def value
      text[9..18]
    end

    def cpf
      text[19..29]
    end

    def card_number
      text[30..41]
    end

    def hour
      text[42..47]
    end

    def owner_name
      text[48..61].strip
    end

    def store_name
      text[62..80].strip
    end

    def parsed_time
      Time.parse("#{date}#{hour}")
    end

    def normalized_value
      value.to_f / 100
    end

    def hash_for_transaction
      {
        transaction_type: transaction_type.to_i,
        date: parsed_time,
        value: normalized_value,
        cpf: cpf,
        card_number: card_number
      }
    end
  end
end

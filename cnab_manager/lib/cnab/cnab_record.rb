# frozen_string_literal: true

module Cnab
  # Class to represent a registry read from a CNAB file
  class CnabRecord
    attr_accessor :text

    def initialize(text)
      self.text = text
    end
  end
end

# frozen_string_literal: true

module Cnab
  # Class to represent a registry read from a CNAB file
  class Parser
    def records_from_file(file)
      cnab_records = []
      text_in_file = file
      text_in_file.each_line do |line|
        cnab_records << Cnab::CnabRecord.new(line)
      end
      cnab_records
    end
  end
end

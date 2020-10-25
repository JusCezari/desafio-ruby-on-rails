# frozen_string_literal: true

# Module to handle transaction types descriptions and value for operations
module TransactionType
  TYPES = {
    1 => 'Débito',
    2 => 'Boleto',
    3 => 'Financiamento',
    4 => 'Crédito',
    5 => 'Recebimento Empréstimo',
    6 => 'Vendas',
    7 => 'Recebimento TED',
    8 => 'Recebimento DOC',
    9 => 'Aluguel'
  }.freeze

  POSITIVE_TYPES = [1, 4, 5, 6, 7, 8].freeze
  NEGATIVE_TYPES = [2, 3, 9].freeze

  def self.desc(type)
    TYPES[type]
  end

  def self.operation_value(type, value)
    return value * -1 if NEGATIVE_TYPES.include?(type)

    value
  end
end

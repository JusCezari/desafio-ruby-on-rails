# frozen_string_literal: true

# Model for Stores
class Store < ApplicationRecord
  has_many :transactions
  validates :name, presence: true
  validates :owner, presence: true

  def total_in_transactions
    total = 0
    transactions.each do |transaction|
      total += TransactionType.operation_value(transaction.transaction_type, transaction.value)
    end
    total
  end
end

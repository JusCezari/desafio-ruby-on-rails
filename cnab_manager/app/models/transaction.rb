# frozen_string_literal: true

# Model for Transactions
class Transaction < ApplicationRecord
  validates :transaction_type, presence: true
  validates :date, presence: true
  validates :value, presence: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :card_number, presence: true
  validates :owner_name, presence: true
  validates :store_name, presence: true
end

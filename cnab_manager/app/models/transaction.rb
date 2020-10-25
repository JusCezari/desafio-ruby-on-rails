# frozen_string_literal: true

# Model for Transactions
class Transaction < ApplicationRecord
  belongs_to :store
  validates :transaction_type, presence: true
  validates :date, presence: true
  validates :value, presence: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :card_number, presence: true
  validates :store, presence: true
end

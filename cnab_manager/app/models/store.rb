# frozen_string_literal: true

# Model for Stores
class Store < ApplicationRecord
  has_many :transactions
  validates :name, presence: true
  validates :owner, presence: true
end

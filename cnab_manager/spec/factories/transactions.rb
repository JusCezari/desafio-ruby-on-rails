# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    transaction_type { Faker::Number.between(from: 1, to: 9) }
    date { Time.now }
    value { Faker::Number.decimal(l_digits: 2) }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    card_number { Faker::Business.credit_card_number }
    store
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :cnab_record, class: Cnab::CnabRecord do
    text do
      Faker::Number.between(from: 1, to: 9).to_s + # Transaction type
        Faker::Date.in_date_period.strftime('%Y%m%d') + # Date of the transaction
        "0000#{Faker::Number.leading_zero_number(digits: 6)}" + # Value with 5 zeros fixed at left
        Faker::IDNumber.brazilian_citizen_number + # Brazilian document (CPF)
        "#{Faker::Number.number(digits: 4)}****#{Faker::Number.number(digits: 4)}" + # Credit card number
        Faker::Time.between(from: 1.day.ago, to: DateTime.now).strftime('%H%M%S') + # Hour of the transaction
        Faker::Lorem.words(number: 5).join(' ').upcase[0..14] + # Owner name
        Faker::Lorem.words(number: 10).join(' ').upcase[0..19] # Store name
    end
  end
end

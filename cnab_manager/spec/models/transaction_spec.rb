# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when checking empty fields' do
    it 'should be valid if all the fields are present' do
      transaction = build(:transaction)
      expect(transaction.valid?).to be_truthy
    end
    it 'should be invalid if there is no type' do
      transaction = build(:transaction, type: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no date' do
      transaction = build(:transaction, date: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no value' do
      transaction = build(:transaction, value: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no cpf' do
      transaction = build(:transaction, cpf: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no card_number' do
      transaction = build(:transaction, card_number: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no owner_name' do
      transaction = build(:transaction, owner_name: nil)
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if there is no store_name' do
      transaction = build(:transaction, store_name: nil)
      expect(transaction.valid?).to be_falsey
    end
  end

  context 'when validating cpf' do
    it 'should be valid if cpf has exactly 11 digits' do
      transaction = build(:transaction, cpf: Faker::Number.leading_zero_number(digits: 11))
      expect(transaction.valid?).to be_truthy
    end
    it 'should be invalid if cpf has less than 11 digits' do
      transaction = build(:transaction, cpf: Faker::Number.leading_zero_number(digits: 10))
      expect(transaction.valid?).to be_falsey
    end
    it 'should be invalid if cpf has more than 11 digits' do
      transaction = build(:transaction, cpf: Faker::Number.leading_zero_number(digits: 12))
      expect(transaction.valid?).to be_falsey
    end
  end
end

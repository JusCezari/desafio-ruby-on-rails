# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'when checking relations' do
    it { should have_many(:transactions) }
  end

  context 'when checking empty fields' do
    it 'should be valid if all the fields are present' do
      store = build(:store)
      expect(store.valid?).to be_truthy
    end
    it 'should be invalid if there is no name' do
      store = build(:store, name: nil)
      expect(store.valid?).to be_falsey
    end
    it 'should be invalid if there is no owner' do
      store = build(:store, owner: nil)
      expect(store.valid?).to be_falsey
    end
  end

  context 'when calculating the total based on transactions' do
    let(:val_a) { 20.12 }
    let(:val_b) { 15.56 }

    it 'should return the correct result based in the transaction types' do
      store_a = create(:store)
      create(:transaction, value: val_a, transaction_type: TransactionType::POSITIVE_TYPES.sample, store_id: store_a.id)
      create(:transaction, value: val_b, transaction_type: TransactionType::NEGATIVE_TYPES.sample, store_id: store_a.id)
      expect(store_a.total_in_transactions).to eq((0 + val_a - val_b).round(2))

      store_b = create(:store)
      create(:transaction, value: val_a, transaction_type: TransactionType::POSITIVE_TYPES.sample, store: store_b)
      create(:transaction, value: val_b, transaction_type: TransactionType::POSITIVE_TYPES.sample, store: store_b)
      expect(store_b.total_in_transactions).to eq((0 + val_a + val_b).round(2))

      store_c = create(:store)
      create(:transaction, value: val_b, transaction_type: TransactionType::NEGATIVE_TYPES.sample, store: store_c)
      create(:transaction, value: val_b, transaction_type: TransactionType::NEGATIVE_TYPES.sample, store: store_c)
      expect(store_c.total_in_transactions).to eq((0 - val_b - val_b).round(2))
    end
  end
end

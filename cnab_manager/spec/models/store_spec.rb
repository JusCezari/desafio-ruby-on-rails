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
end

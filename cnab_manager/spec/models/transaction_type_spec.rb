# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  context 'when checking transaction types' do
    it 'should have only 9 transaction types' do
      expect(TransactionType::TYPES.size).to eq(9)
    end
    it "should have 'Débito' as code 1" do
      expect(TransactionType::TYPES[1]).to eq('Débito')
    end
    it "should have 'Boleto' as code 2" do
      expect(TransactionType::TYPES[2]).to eq('Boleto')
    end
    it "should have 'Financiamento' as code 3" do
      expect(TransactionType::TYPES[3]).to eq('Financiamento')
    end
    it "should have 'Crédito' as code 4" do
      expect(TransactionType::TYPES[4]).to eq('Crédito')
    end
    it "should have 'Recebimento Empréstimo' as code 5" do
      expect(TransactionType::TYPES[5]).to eq('Recebimento Empréstimo')
    end
    it "should have 'Vendas' as code 6" do
      expect(TransactionType::TYPES[6]).to eq('Vendas')
    end
    it "should have 'Recebimento TED' as code 7" do
      expect(TransactionType::TYPES[7]).to eq('Recebimento TED')
    end
    it "should have 'Recebimento DOC' as code 8" do
      expect(TransactionType::TYPES[8]).to eq('Recebimento DOC')
    end
    it "should have 'Aluguel' as code 9" do
      expect(TransactionType::TYPES[9]).to eq('Aluguel')
    end

    context 'that should subtract instead add' do
      it 'should have only 3 types that subtract' do
        expect(TransactionType::NEGATIVE_TYPES.size).to eq(3)
      end
      it 'should permit only transaction types 2, 3 and 9 to subtract' do
        expect(TransactionType::NEGATIVE_TYPES).to include(2, 3, 9)
      end
    end
  end

  context 'auxiliary static functions' do
    context '#desc' do
      it 'should return the correct description for the given type' do
        expect(TransactionType.desc(1)).to eq('Débito')
        expect(TransactionType.desc(2)).to eq(TransactionType::TYPES[2])
      end
    end

    context '#operation_value' do
      it 'should return a positive value when it is a add operation' do
        expect(TransactionType.operation_value(TransactionType::POSITIVE_TYPES.sample, 100)).to eq(100)
      end

      it 'should return a negative value when it is a subtract operation' do
        expect(TransactionType.operation_value(TransactionType::NEGATIVE_TYPES.sample, 100)).to eq(-100)
      end
    end
  end
end

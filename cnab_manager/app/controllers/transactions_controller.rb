# frozen_string_literal: true

# Transactions controller class
class TransactionsController < ApplicationController
  def index
    all_transactions = Transaction.order(:date).all
    @grouped_transactions = group_transactions_by_store_name(all_transactions)
  end

  def add; end

  def upload
    if params.dig(:transactions, :transactions_file).present?
      transactions_file = File.read(params[:transactions][:transactions_file])
      saved_transactions = save_cnab_records_from_file(transactions_file)
      flash[:success] = "#{saved_transactions.size} transações adicionadas ao sistema"
    else
      flash[:notice] = 'Nenhum arquivo enviado'
    end

    redirect_to transactions_url
  end

  private

  def save_cnab_records_from_file(file)
    saved_transactions = []
    cnab_parser = Cnab::Parser.new
    records = cnab_parser.records_from_file(file)
    records.each do |record|
      saved_transactions << Transaction.create(record.hash_for_transaction)
    end
    saved_transactions
  end

  def group_transactions_by_store_name(transactions)
    stores = {}
    transactions.each do |transaction|
      store_name = transaction.store_name
      if stores[store_name].blank?
        stores[store_name] = base_hash_grouped_transactions(store_name, transaction.owner_name)
      end
      stores[store_name][:transactions] << transaction
      stores[store_name][:total] += TransactionType.operation_value(transaction.transaction_type, transaction.value)
    end
    stores
  end

  def base_hash_grouped_transactions(store_name, owner_name)
    {
      store_name: store_name,
      owner_name: owner_name,
      total: 0,
      transactions: []
    }
  end
end

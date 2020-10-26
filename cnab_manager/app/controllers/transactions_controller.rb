# frozen_string_literal: true

# Transactions controller class
class TransactionsController < ApplicationController
  def index
    @aux_title = 'Transações'
    @stores = Store.includes(:transactions).order(:name).all
  end

  def add
    @aux_title = 'Importar arquivo CNAB'
  end

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
      store = Store.find_or_create_by(name: record.store_name, owner: record.owner_name)
      transaction_to_save = Transaction.new(record.hash_for_transaction)
      transaction_to_save.store = store
      saved_transactions << transaction_to_save.save
    end
    saved_transactions
  end
end

# frozen_string_literal: true

# Transactions controller class
class TransactionsController < ApplicationController
  def index
    render json: Transaction.all
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
end

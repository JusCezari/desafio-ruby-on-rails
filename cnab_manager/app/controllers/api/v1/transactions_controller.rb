# frozen_string_literal: true

module Api
  module V1
    # Transactions controller for API
    class TransactionsController < ApplicationController
      def list
        query = Transaction.includes(:store).all

        query = query.where(transaction_type: params[:transaction_type]) if params[:transaction_type].present?

        query = adapt_query_for_store(params[:store_name], query) if params[:store_name].present?

        render json: adapt_to_json(query)
      end

      def get
        render json: Transaction.where(id: params[:id]).first
      end

      private

      def adapt_query_for_store(store_name, query)
        stores = Store.where(name: store_name)
        query.where(store_id: stores)
      end

      def adapt_to_json(transactions)
        transactions.map do |transaction|
          {
            id: transaction.id, transaction_type: transaction.transaction_type,
            date: transaction.date, value: transaction.value,
            cpf: transaction.cpf, card_number: transaction.card_number,
            owner_name: transaction.store.owner, store_name: transaction.store.name,
            created_at: transaction.created_at, updated_at: transaction.updated_at
          }
        end
      end
    end
  end
end

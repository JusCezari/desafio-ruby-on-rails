# frozen_string_literal: true

module Api
  module V1
    # Transactions controller for API
    class TransactionsController < ApplicationController
      def list
        query = Transaction.all

        query = query.where(transaction_type: params[:transaction_type]) if params[:transaction_type].present?

        query = query.where(id: params[:store_name]) if params[:store_name].present?

        render json: query
      end

      def get
        render json: Transaction.where(id: params[:id]).first
      end
    end
  end
end

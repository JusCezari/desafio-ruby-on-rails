# frozen_string_literal: true

# Transactions controller class
class TransactionsController < ApplicationController
  def index; end

  def add; end

  def upload
    render json: {
      status: 'OK'
    }
  end
end

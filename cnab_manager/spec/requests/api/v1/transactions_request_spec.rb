# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Transactions', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/api/v1/transactions'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /:id' do
    it 'returns http success' do
      get '/api/v1/transactions/0'
      expect(response).to have_http_status(:success)
    end
  end
end

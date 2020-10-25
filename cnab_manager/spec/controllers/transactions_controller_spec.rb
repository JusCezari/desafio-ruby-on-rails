# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'GET /index' do
    it 'should return HTTP success code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /add' do
    it 'should return HTTP success code' do
      get :add
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /upload' do
    it 'should return HTTP success code' do
      post :upload
      expect(response).to have_http_status(:success)
    end
  end
end

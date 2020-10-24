# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET /index' do
    it 'should return HTTP success code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end

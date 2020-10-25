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
      expect(response).to redirect_to transactions_url
    end

    context 'when uploading new file with CNAB records' do
      
      let(:number_of_records_in_mocked_file) { 21 }
      let(:fixture_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'CNAB.txt') }
      let(:mocked_file) { Rack::Test::UploadedFile.new(fixture_file_path, 'text/plain', true) }

      before :example do
        Transaction.destroy_all
      end

      it 'should save all the CNAB records present in the file' do
        params = { "transactions" => { "transactions_file" => mocked_file } }
        expect{
          post :upload, params: params
        }.to change(Transaction, :count).by(number_of_records_in_mocked_file)        
      end

      it 'should set a message in flash[:success] showing how many transactions were saved' do
        params = { "transactions" => { "transactions_file" => mocked_file } }
        post :upload, params: params
        expect(flash[:success]).to match("#{number_of_records_in_mocked_file} transações adicionadas ao sistema")
      end

      it 'should set a message in flash[:notice] if no file is provided' do
        params = { "transactions" => { "transactions_file" => nil } }
        post :upload, params: params
        expect(flash[:notice]).to match('Nenhum arquivo enviado')
      end

    end
    
  end
end

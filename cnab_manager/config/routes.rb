# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'transactions' => 'transactions#index'
  get 'transactions/add'
  post 'transactions/upload'

  namespace :api do
    namespace :v1 do
      get 'transactions' => 'transactions#list'
      get 'transactions/:id' => 'transactions#get'
    end
  end
end

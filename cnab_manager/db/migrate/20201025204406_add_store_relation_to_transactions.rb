# frozen_string_literal: true

# Migration to add reference to a store in a transaction
class AddStoreRelationToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :store, index: true, foreign_key: true
  end
end

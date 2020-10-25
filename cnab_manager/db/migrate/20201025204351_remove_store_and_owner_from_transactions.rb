# frozen_string_literal: true

# Migration to remove fields that will be store in store entity
class RemoveStoreAndOwnerFromTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :store_name
    remove_column :transactions, :owner_name
  end
end

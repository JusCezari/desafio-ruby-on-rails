# frozen_string_literal: true

# Migration to correct mistake at using type as an attribute since it's a reserved keyword
class ChangeColumnTypeToTransactionType < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :type, :transaction_type
  end
end

# frozen_string_literal: true

# Migration to create the table to save transactions
class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :type, limit: 1, null: false
      t.datetime :date, null: false
      t.float :value, null: false
      t.string :cpf, limit: 11, null: false
      t.string :card_number, null: false
      t.string :owner_name, null: false
      t.string :store_name, null: false

      t.timestamps
    end
  end
end

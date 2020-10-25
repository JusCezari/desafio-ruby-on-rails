# frozen_string_literal: true

# Migration to normalize stores creating an entity for it
class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :owner

      t.timestamps
    end
  end
end

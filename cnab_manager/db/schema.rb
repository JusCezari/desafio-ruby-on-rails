# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_024_232_857) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'transactions', force: :cascade do |t|
    t.integer 'type', limit: 2, null: false
    t.datetime 'date', null: false
    t.float 'value', null: false
    t.string 'cpf', limit: 11, null: false
    t.string 'card_number', null: false
    t.string 'owner_name', null: false
    t.string 'store_name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end

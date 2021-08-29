# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_29_213414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "installements", force: :cascade do |t|
    t.integer "percentage"
    t.bigint "po_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_installements_on_po_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.string "name"
    t.bigint "statement_id", null: false
    t.text "description"
    t.float "cost"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id"], name: "index_line_items_on_statement_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "address"
    t.text "pos"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "po_number"
    t.string "service_type"
    t.float "po_amount"
    t.float "amount_owed"
    t.float "amount_paid"
    t.boolean "taxable"
    t.string "issued_to"
    t.string "company_name"
    t.string "learning_coordinator"
    t.string "coachee_name"
    t.string "approved_by"
    t.integer "associate_percentage"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_pos_on_user_id"
  end

  create_table "statements", force: :cascade do |t|
    t.integer "number"
    t.integer "issued_by"
    t.bigint "po_id", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_statements_on_po_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "installements", "pos"
  add_foreign_key "line_items", "statements"
  add_foreign_key "statements", "pos"
end

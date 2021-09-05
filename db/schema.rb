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

ActiveRecord::Schema.define(version: 2021_09_05_180017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.integer "percentage"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line_item_id"], name: "index_discounts_on_line_item_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "installments", force: :cascade do |t|
    t.integer "percentage"
    t.datetime "due_date"
    t.bigint "po_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_installments_on_po_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "statement_id"
    t.string "title"
    t.text "description"
    t.decimal "cost", precision: 5, scale: 2
    t.boolean "taxable", default: true
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id"], name: "index_line_items_on_statement_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "type"
    t.boolean "revinue_share", default: false
    t.decimal "tax_rate", precision: 5, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "emailaddress_ciphertext"
    t.text "name_ciphertext"
    t.text "phone_ciphertext"
    t.text "pos_ciphertext"
    t.text "address_ciphertext"
    t.string "emailaddress_bidx"
    t.string "name_bidx"
    t.string "phone_bidx"
    t.string "po_bidx"
    t.string "address_bidx"
    t.index ["address_bidx"], name: "index_participants_on_address_bidx", unique: true
    t.index ["emailaddress_bidx"], name: "index_participants_on_emailaddress_bidx", unique: true
    t.index ["name_bidx"], name: "index_participants_on_name_bidx", unique: true
    t.index ["phone_bidx"], name: "index_participants_on_phone_bidx", unique: true
    t.index ["po_bidx"], name: "index_participants_on_po_bidx", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "expected_amount", precision: 5, scale: 2
    t.decimal "amount_received", precision: 5, scale: 2
    t.string "reference_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "po_users", force: :cascade do |t|
    t.bigint "po_id"
    t.boolean "facilitator", default: false
    t.boolean "got_po", default: false
    t.text "participants_ciphertext"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_po_users_on_po_id"
  end

  create_table "pos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "po_number"
    t.string "service_type"
    t.integer "number_of_installments"
    t.string "tax_amount"
    t.string "issued_to"
    t.string "company_name"
    t.string "learning_coordinator"
    t.string "coachee_name"
    t.string "approved_by"
    t.integer "associate_percentage"
    t.integer "founder_percentage"
    t.float "revenue_share"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["po_number"], name: "index_pos_on_po_number", unique: true
    t.index ["slug"], name: "index_pos_on_slug", unique: true
    t.index ["user_id"], name: "index_pos_on_user_id"
  end

  create_table "statements", force: :cascade do |t|
    t.bigint "po_id"
    t.string "type"
    t.text "terms"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_statements_on_po_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.text "email_ciphertext"
    t.string "email_bidx"
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "discounts", "line_items"
  add_foreign_key "installments", "pos"
end

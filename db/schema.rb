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

ActiveRecord::Schema.define(version: 2022_01_23_185214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "company_options", default: {}
    t.text "default_client_note"
    t.text "default_associate_note"
    t.text "default_client_terms"
    t.text "default_associate_terms"
  end

  create_table "details", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "hours"
    t.string "completed_by"
    t.integer "line_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line_item_id"], name: "index_details_on_line_item_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.integer "amount"
    t.integer "amount_type"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amount_type"], name: "index_discounts_on_amount_type"
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

  create_table "groups", force: :cascade do |t|
    t.bigint "po_id"
    t.integer "bill_to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["po_id"], name: "index_groups_on_po_id"
  end

  create_table "installments", force: :cascade do |t|
    t.integer "percentage"
    t.datetime "due_date"
    t.bigint "po_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.index ["po_id"], name: "index_installments_on_po_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "po_id"
    t.string "name"
    t.integer "participant_id"
    t.text "description"
    t.float "tax_rate"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "terms"
    t.text "notes"
    t.string "invoice_number"
    t.string "type_of"
    t.string "currency"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "cost"
    t.boolean "taxable", default: false
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_items_on_invoice_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "statement_id"
    t.string "title"
    t.text "description"
    t.decimal "cost", precision: 20, scale: 2
    t.boolean "taxable", default: true
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "expense_exempt_from_tax", default: false
    t.decimal "expense_cost"
    t.index ["statement_id"], name: "index_line_items_on_statement_id"
    t.index ["type"], name: "index_line_items_on_type"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.integer "po_user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_members_on_group_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "type"
    t.boolean "revenue_share", default: false
    t.decimal "tax_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "emailaddress_ciphertext"
    t.text "name_ciphertext"
    t.text "phone_ciphertext"
    t.text "address_ciphertext"
    t.string "emailaddress_bidx"
    t.string "name_bidx"
    t.string "phone_bidx"
    t.string "address_bidx"
    t.string "country_code"
    t.text "title_ciphertext"
    t.text "city_ciphertext"
    t.text "state_ciphertext"
    t.text "zip_ciphertext"
    t.text "company_ciphertext"
    t.string "company_bidx"
    t.string "city_bidx"
    t.string "state_bidx"
    t.string "zip_bidx"
    t.string "currency"
    t.index ["address_bidx"], name: "index_participants_on_address_bidx", unique: true
    t.index ["city_bidx"], name: "index_participants_on_city_bidx"
    t.index ["company_bidx"], name: "index_participants_on_company_bidx"
    t.index ["emailaddress_bidx"], name: "index_participants_on_emailaddress_bidx", unique: true
    t.index ["name_bidx"], name: "index_participants_on_name_bidx", unique: true
    t.index ["phone_bidx"], name: "index_participants_on_phone_bidx", unique: true
    t.index ["state_bidx"], name: "index_participants_on_state_bidx"
    t.index ["type"], name: "index_participants_on_type"
    t.index ["zip_bidx"], name: "index_participants_on_zip_bidx"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "expected_amount", precision: 20, scale: 2
    t.decimal "amount_received", precision: 20, scale: 2
    t.string "currency"
    t.string "reference_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "po_users", force: :cascade do |t|
    t.integer "po_id"
    t.integer "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["participant_id"], name: "index_po_users_on_participant_id"
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
    t.string "issued_to_ciphertext"
    t.string "company_name_ciphertext"
    t.string "learning_coordinator_ciphertext"
    t.string "found_ciphertext"
    t.string "approved_by_ciphertext"
    t.integer "associate_percentage"
    t.integer "founder_percentage"
    t.float "revenue_share"
    t.string "status"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name_bidx"
    t.string "issued_to_bidx"
    t.string "found_bidx"
    t.string "slug"
    t.string "issue_code"
    t.index ["company_name_bidx"], name: "index_pos_on_company_name_bidx"
    t.index ["found_bidx"], name: "index_pos_on_found_bidx"
    t.index ["issued_to_bidx"], name: "index_pos_on_issued_to_bidx"
    t.index ["po_number"], name: "index_pos_on_po_number", unique: true
    t.index ["slug"], name: "index_pos_on_slug", unique: true
    t.index ["user_id"], name: "index_pos_on_user_id"
  end

  create_table "rusers", force: :cascade do |t|
    t.integer "po_id"
    t.integer "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "saved_details", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "hours"
    t.string "completed_by"
    t.integer "saved_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["saved_item_id"], name: "index_saved_details_on_saved_item_id"
  end

  create_table "saved_items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "cost"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "expense_exempt_from_tax", default: false
    t.boolean "taxable", default: true
    t.decimal "expense_cost"
  end

  create_table "statement_notes", force: :cascade do |t|
    t.text "terms"
    t.text "notes"
    t.bigint "statement_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id"], name: "index_statement_notes_on_statement_id"
  end

  create_table "statements", force: :cascade do |t|
    t.bigint "po_id"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "show_detailed", default: false
    t.string "company_name"
    t.text "company_address"
    t.string "participant_name_ciphertext"
    t.text "participant_address_ciphertext"
    t.decimal "total"
    t.string "invoice_number"
    t.string "status_code"
    t.float "percentage"
    t.integer "issued_to"
    t.text "versions"
    t.string "currency"
    t.index ["po_id"], name: "index_statements_on_po_id"
    t.index ["type"], name: "index_statements_on_type"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "discounts", "line_items"
  add_foreign_key "installments", "pos"
  add_foreign_key "invoices", "users"
  add_foreign_key "items", "invoices"
  add_foreign_key "members", "groups"
  add_foreign_key "statement_notes", "statements"
end

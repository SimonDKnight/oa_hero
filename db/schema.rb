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

ActiveRecord::Schema[8.0].define(version: 2025_07_15_122857) do
  create_schema "_heroku"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"

  create_table "licenses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "license_key"
    t.string "plan"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_licenses_on_user_id"
  end

  create_table "restricted_brands", force: :cascade do |t|
    t.string "name"
    t.boolean "restricted"
    t.boolean "transparency"
    t.boolean "private_label"
    t.boolean "intellectual_property"
    t.boolean "parallel_import"
    t.boolean "hard_gated"
    t.integer "source"
    t.text "general_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "lc_name"
    t.string "name"
    t.text "url"
    t.string "reclaim_vat"
    t.string "vat_number"
    t.string "customer_service_email"
    t.text "qty_limit"
    t.text "order_limit"
    t.boolean "allow_resellers"
    t.text "vat_invoice_info"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.string "encrypted_password"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "licenses", "users"
end

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

ActiveRecord::Schema[7.0].define(version: 2023_06_12_075614) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "icon", default: "", null: false
    t.integer "members_ids", default: [], array: true
    t.string "kind", default: "expense", null: false
    t.bigint "user_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_categories_on_member_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "categories_members", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "member_id", null: false
    t.index ["category_id", "member_id"], name: "index_categories_members_on_category_id_and_member_id"
    t.index ["member_id", "category_id"], name: "index_categories_members_on_member_id_and_category_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "kind", default: "member"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "total_amounts", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.string "kind", default: "expense", null: false
    t.bigint "member_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_total_amounts_on_category_id"
    t.index ["member_id"], name: "index_total_amounts_on_member_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "group", default: "", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.bigint "category_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "member_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "avatar"
    t.string "username"
    t.text "bio"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "members"
  add_foreign_key "categories", "users"
  add_foreign_key "members", "users"
  add_foreign_key "total_amounts", "categories"
  add_foreign_key "total_amounts", "members"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "members"
end

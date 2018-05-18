# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180518101145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composts", force: :cascade do |t|
    t.string "address"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: false
    t.boolean "deleted", default: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_composts_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "compost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compost_id"], name: "index_conversations_on_compost_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "conversation_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "username"
    t.string "photo", default: "image/upload/v1522224406/contact_compostme.app_sfxgka.png"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "composts", "users"
  add_foreign_key "conversations", "composts"
  add_foreign_key "conversations", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end

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

ActiveRecord::Schema.define(version: 20170329020122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.float    "lat"
    t.float    "lng"
    t.string   "geocoded_street"
    t.string   "geocoded_city"
    t.string   "geocoded_state"
    t.string   "geocoded_country"
    t.string   "geocoded_zipcode"
    t.string   "geocoded_address"
    t.string   "concernable_type"
    t.integer  "concernable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["concernable_id"], name: "index_addresses_on_concernable_id", using: :btree
    t.index ["concernable_type"], name: "index_addresses_on_concernable_type", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "paw_up_count", default: 0
    t.integer  "status",       default: 0
    t.string   "phone"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["paw_up_count"], name: "index_businesses_on_paw_up_count", using: :btree
    t.index ["status"], name: "index_businesses_on_status", using: :btree
    t.index ["user_id"], name: "index_businesses_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_conversations_on_user_id", using: :btree
  end

  create_table "discounts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "reg_price",      precision: 8, scale: 2
    t.decimal  "decimal",        precision: 8, scale: 2
    t.decimal  "discount_price", precision: 8, scale: 2
    t.integer  "business_id"
    t.integer  "percent"
    t.boolean  "active",                                 default: true
    t.string   "img_url"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.boolean  "public",                                 default: false
    t.index ["active"], name: "index_discounts_on_active", using: :btree
    t.index ["business_id"], name: "index_discounts_on_business_id", using: :btree
    t.index ["percent"], name: "index_discounts_on_percent", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "name"
    t.string   "remote_id"
    t.string   "bytes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_images_on_imageable_type", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "log_itemable_id"
    t.string   "log_itemable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["log_itemable_id"], name: "index_logs_on_log_itemable_id", using: :btree
    t.index ["log_itemable_type"], name: "index_logs_on_log_itemable_type", using: :btree
    t.index ["user_id"], name: "index_logs_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "name"
    t.string   "subject"
    t.text     "body"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "paw_ups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["business_id"], name: "index_paw_ups_on_business_id", using: :btree
    t.index ["user_id"], name: "index_paw_ups_on_user_id", using: :btree
  end

  create_table "search_results", force: :cascade do |t|
    t.string   "json"
    t.string   "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["term"], name: "index_search_results_on_term", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "name"
    t.string   "facebook_location"
    t.string   "facebook_cover"
    t.string   "facebook_age_range_min"
    t.string   "facebook_link"
    t.string   "gender"
    t.string   "facebook_timezone"
    t.string   "facebook_picture"
    t.integer  "status",                  default: 1
    t.string   "facebook_locale"
    t.string   "google_locale"
    t.string   "facebook_cover_offset_y"
    t.string   "facebook_age_range_max"
    t.string   "google_picture"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end

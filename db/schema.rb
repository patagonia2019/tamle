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

ActiveRecord::Schema.define(version: 20180207115640) do

  create_table "consumes", force: :cascade do |t|
    t.date     "at_date"
    t.decimal  "water_fix_consume_amount"
    t.decimal  "water_provision_amount"
    t.integer  "exceedance_m3"
    t.decimal  "exceedance_m3_amount"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.decimal  "social_quote_amount"
    t.integer  "number_of_members"
  end

  create_table "emissions", force: :cascade do |t|
    t.integer  "medition_id"
    t.integer  "previous_medition_id"
    t.date     "at_emission_date"
    t.integer  "consume_id"
    t.integer  "water_previous_measure"
    t.integer  "water_measure"
    t.integer  "water_consumed"
    t.integer  "exceedance_m3"
    t.decimal  "exceedance_amount"
    t.date     "ceb_date"
    t.decimal  "ceb_amount"
    t.decimal  "social_quote_amount"
    t.decimal  "balance_previous_amount"
    t.date     "balance_previous_date"
    t.decimal  "payment_amount"
    t.date     "payment_date"
    t.decimal  "balance_amount"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.decimal  "ceb_amount_by_user"
    t.integer  "exceedance_m3_by_user"
    t.decimal  "exceedance_m3_amount_on_user"
    t.decimal  "water_fix_consume_amount"
    t.decimal  "water_fix_consume_on_user_amount"
    t.decimal  "water_provision_amount"
    t.decimal  "water_provision_on_user_amount"
    t.integer  "invoice_id"
    t.integer  "user_id"
    t.decimal  "sia_amount"
    t.date     "sia_date"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "billed_date"
    t.boolean  "billed"
    t.date     "at_date"
  end

  create_table "meditions", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "at_date"
    t.integer  "measure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "billed"
    t.integer  "invoice_id"
  end

  create_table "movements", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "at_date"
    t.integer  "month"
    t.integer  "year"
    t.string   "concept"
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "isdebe"
    t.         "fieldname"
    t.boolean  "haber"
    t.boolean  "iscredit"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "at_date"
    t.string   "concept"
    t.decimal  "amount"
    t.boolean  "is_credit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "picture"
    t.integer  "medition_id"
    t.integer  "invoice_id"
    t.boolean  "billed"
    t.string   "facturaoriginal_file_name"
    t.string   "facturaoriginal_content_type"
    t.integer  "facturaoriginal_file_size"
    t.datetime "facturaoriginal_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "address"
    t.string   "catastro"
    t.string   "phone"
    t.string   "mobile"
  end

end

# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140902201704) do

  create_table "costs", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "costs_courses", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "cost_id"
  end

  add_index "costs_courses", ["course_id", "cost_id"], :name => "index_costs_courses_on_course_id_and_cost_id"

  create_table "coupons", :force => true do |t|
    t.decimal  "amount",         :precision => 8, :scale => 2, :default => 0.0
    t.string   "code"
    t.integer  "max_uses"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "course_type_id"
    t.string   "kind"
    t.date     "expires_at"
  end

  create_table "coupons_program_courses", :id => false, :force => true do |t|
    t.integer "coupon_id"
    t.integer "program_course_id"
  end

  add_index "coupons_program_courses", ["coupon_id"], :name => "index_coupons_program_courses_on_coupon_id"
  add_index "coupons_program_courses", ["program_course_id"], :name => "index_coupons_program_courses_on_program_course_id"

  create_table "course_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "courses", :force => true do |t|
    t.string   "group"
    t.decimal  "price",             :precision => 8, :scale => 2, :default => 0.0
    t.integer  "capacity",                                        :default => 0
    t.boolean  "visible",                                         :default => false
    t.integer  "program_course_id"
    t.integer  "tutor_id"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.boolean  "cash"
    t.boolean  "turbo"
    t.integer  "course_type_id"
    t.boolean  "active",                                          :default => true
    t.text     "details"
  end

  add_index "courses", ["program_course_id"], :name => "index_courses_on_program_course_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.integer  "institute_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "faculties", ["institute_id"], :name => "index_faculties_on_institute_id"

  create_table "faculty_programs", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.integer  "faculty_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "faculty_programs", ["faculty_id"], :name => "index_faculty_programs_on_faculty_id"

  create_table "faculty_programs_program_courses", :id => false, :force => true do |t|
    t.integer "faculty_program_id"
    t.integer "program_course_id"
  end

  add_index "faculty_programs_program_courses", ["faculty_program_id"], :name => "index_faculty_program_courses_on_faculty_program_id"
  add_index "faculty_programs_program_courses", ["program_course_id"], :name => "index_faculty_program_courses_on_program_course_id"

  create_table "institutes", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "city"
    t.string   "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "managers_program_courses", :id => false, :force => true do |t|
    t.integer "program_course_id"
    t.integer "manager_id"
  end

  add_index "managers_program_courses", ["program_course_id", "manager_id"], :name => "index_program_courses_users_on_program_course_id_and_user_id"

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "orders", :force => true do |t|
    t.boolean  "payed",           :default => false
    t.text     "cart_course_ids"
    t.integer  "customer_id"
    t.integer  "coupon_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_user_id"

  create_table "program_courses", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.integer  "year"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  create_table "registrations", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "order_id"
    t.integer  "course_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
  end

  add_index "registrations", ["course_id"], :name => "index_registrations_on_course_id"
  add_index "registrations", ["customer_id"], :name => "index_registrations_on_user_id"

  create_table "timeslots", :force => true do |t|
    t.string   "location",   :default => ""
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "course_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "timeslots", ["course_id"], :name => "index_timeslots_on_course_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "type"
    t.string   "first_name"
    t.string   "insertion"
    t.string   "last_name"
    t.string   "telephone"
    t.string   "address_street"
    t.string   "address_number"
    t.string   "address_zip"
    t.string   "address_residence"
    t.integer  "institute_id"
    t.integer  "faculty_id"
    t.integer  "faculty_program_id"
    t.string   "student_number"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end

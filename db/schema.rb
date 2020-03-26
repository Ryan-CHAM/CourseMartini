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

ActiveRecord::Schema.define(version: 2020_03_26_091326) do

  create_table "comments", force: :cascade do |t|
    t.text "posts"
    t.float "score", default: 0.0
    t.float "workload_score", default: 0.0
    t.float "teachingQuality_score", default: 0.0
    t.float "difficulty_score", default: 0.0
    t.float "usefulness_score", default: 0.0
    t.string "username"
    t.string "courseid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "subject"
    t.string "faculty"
    t.text "description"
    t.float "workload"
    t.float "difficulty"
    t.float "quality"
    t.float "usefulness"
    t.float "overall"
    t.float "gpa"
    t.integer "n_comments"
    t.text "book"
    t.text "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

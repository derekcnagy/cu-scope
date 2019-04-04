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

ActiveRecord::Schema.define(version: 2019_04_01_215607) do

  create_table "error_messages", force: :cascade do |t|
    t.string "error_message", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string "feature_name", null: false
    t.string "feature_description"
    t.string "json_feature_id", null: false
    t.integer "team_id"
    t.index ["team_id"], name: "index_features_on_team_id"
  end

  create_table "individual_tests", force: :cascade do |t|
    t.boolean "passed", null: false
    t.integer "duration", null: false
    t.integer "test_run_id", null: false
    t.integer "scenario_id", null: false
    t.integer "error_message_id"
    t.string "error_location"
    t.string "full_error_message"
    t.index ["error_message_id"], name: "index_individual_tests_on_error_message_id"
    t.index ["scenario_id"], name: "index_individual_tests_on_scenario_id"
    t.index ["test_run_id"], name: "index_individual_tests_on_test_run_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "note", null: false
    t.integer "scenario_id"
    t.integer "error_message_id"
    t.integer "individual_test_id"
    t.integer "team_id"
    t.integer "user_id", null: false
    t.datetime "date_created"
    t.datetime "last_date_invoked"
    t.index ["error_message_id"], name: "index_notes_on_error_message_id"
    t.index ["individual_test_id"], name: "index_notes_on_individual_test_id"
    t.index ["scenario_id"], name: "index_notes_on_scenario_id"
    t.index ["team_id"], name: "index_notes_on_team_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "profile_name", null: false
    t.integer "team_id", null: false
    t.index ["team_id"], name: "index_profiles_on_team_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.string "scenario_name", null: false
    t.string "scenario_description"
    t.string "steps", null: false
    t.string "json_scenario_id", null: false
    t.integer "feature_id", null: false
    t.index ["feature_id"], name: "index_scenarios_on_feature_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name", null: false
  end

  create_table "test_runs", force: :cascade do |t|
    t.string "test_run_name", null: false
    t.datetime "time_ran"
    t.integer "team_id"
    t.integer "profile_id"
    t.index ["profile_id"], name: "index_test_runs_on_profile_id"
    t.index ["team_id"], name: "index_test_runs_on_team_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "type_name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest"
    t.integer "team_id"
    t.integer "user_type_id", null: false
    t.integer "profile_id"
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["team_id"], name: "index_users_on_team_id"
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

end

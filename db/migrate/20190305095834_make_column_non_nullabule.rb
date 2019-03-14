class MakeColumnNonNullabule < ActiveRecord::Migration[5.2]
  def change
    change_column :error_messages, :error_message, :string, null: false

    change_column :features, :feature_name, :string, null: false
    change_column :features, :json_feature_id, :string, null: false

    change_column :individual_tests, :passed, :boolean, null: false
    change_column :individual_tests, :duration, :integer, null: false
    change_column :individual_tests, :test_run_id, :integer, null: false
    change_column :individual_tests, :scenario_id, :integer, null: false

    change_column :notes, :note, :string, null: false
    change_column :notes, :user_id, :integer, null: false

    change_column :profiles, :profile_name, :string, null: false
    change_column :profiles, :team_id, :integer, null: false

    change_column :scenarios, :scenario_name, :string, null: false
    change_column :scenarios, :steps, :string, null: false
    change_column :scenarios, :json_scenario_id, :string, null: false
    change_column :scenarios, :feature_id, :integer, null: false

    change_column :teams, :team_name, :string, null: false

    change_column :test_runs, :test_run_name, :string, null: false

    change_column :users, :username, :string, null: false
    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
    change_column :users, :user_type_id, :integer, null: false

    change_column :user_types, :type_name, :string, null: false
  end
end

class RenameIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :error_messages, :error_messages_id, :error_message_id
    rename_column :features, :features_id, :feature_id
    rename_column :features, :teams_id, :team_id
    rename_column :individual_tests, :tests_id, :individual_test_id
    rename_column :individual_tests, :test_runs_id, :test_run_id
    rename_column :individual_tests, :scenarios_id, :scenario_id
    rename_column :individual_tests, :error_messages_id, :error_message_id
    rename_column :notes, :notes_id, :note_id
    rename_column :notes, :scenarios_id, :scenario_id
    rename_column :notes, :error_messages_id, :error_message_id
    rename_column :notes, :tests_id, :individual_test_id
    rename_column :notes, :teams_id, :team_id
    rename_column :notes, :users_id, :user_id
    rename_column :profiles, :profiles_id, :profile_id
    rename_column :profiles, :teams_id, :team_id
    rename_column :scenarios, :scenarios_id, :scenario_id
    rename_column :scenarios, :features_id, :feature_id
    rename_column :teams, :teams_id, :teams_id
    rename_column :test_runs, :test_runs_id, :test_run_id
    rename_column :test_runs, :teams_id, :team_id
    rename_column :test_runs, :profiles_id, :profile_id
    rename_column :users, :users_id, :user_id
    rename_column :users, :teams_id, :team_id
    rename_column :users, :user_types_id, :user_type_id
    rename_column :users, :profiles_id, :profile_id
    rename_column :user_types, :user_types_id, :user_type_id
  end
end

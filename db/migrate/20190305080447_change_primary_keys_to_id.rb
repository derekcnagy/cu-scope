class ChangePrimaryKeysToId < ActiveRecord::Migration[5.2]
  def change
    rename_column :error_messages, :error_message_id, :id
    rename_column :features, :feature_id, :id
    rename_column :individual_tests, :individual_test_id, :id
    rename_column :notes, :note_id, :id
    rename_column :profiles, :profile_id, :id
    rename_column :scenarios, :scenario_id, :id
    rename_column :teams, :teams_id, :id
    rename_column :test_runs, :test_run_id, :id
    rename_column :users, :user_id, :id
    rename_column :user_types, :user_type_id, :id
  end
end

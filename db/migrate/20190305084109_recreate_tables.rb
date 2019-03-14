class RecreateTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :error_messages
    drop_table :features
    drop_table :individual_tests
    drop_table :notes
    drop_table :profiles
    drop_table :scenarios
    drop_table :teams
    drop_table :test_runs
    drop_table :users
    drop_table :user_types

    create_table :error_messages do |table|
      table.string :error_message
    end
    create_table :user_types do |table|
      table.string :type_name
    end
    create_table :teams do |table|
      table.string :team_name
    end
    create_table :features do |table|
      table.string :feature_name
      table.string :feature_description
      table.string :json_feature_id
      table.references :team
    end
    create_table :profiles do |table|
      table.string :profile_name
      table.references :team
    end
    create_table :scenarios do |table|
      table.string :scenario_name
      table.string :scenario_description
      table.string :steps
      table.string :json_scenario_id
      table.references :feature
    end
    create_table :test_runs do |table|
      table.string :test_run_name
      table.timestamp :time_ran
      table.references :team, :profile
    end
    create_table :users do |table|
      table.string :username
      table.string :first_name
      table.string :last_name
      table.string :password_digest
      table.references :team, :user_type, :profile
    end
    create_table :individual_tests do |table|
      table.boolean :passed
      table.integer :duration
      table.references :test_run, :scenario, :error_message
    end
    create_table :notes do |table|
      table.string :note
      table.references :scenario, :error_message, :individual_test, :team, :user
    end
  end
end

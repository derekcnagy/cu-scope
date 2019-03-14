class TestRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :test_runs, primary_key: :test_runs_id do |table|
      table.datetime :time_ran
      table.integer :teams_id
      table.integer :profiles_id
    end
  end
end

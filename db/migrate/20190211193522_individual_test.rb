class IndividualTest < ActiveRecord::Migration[5.2]
  def change
    create_table :tests, primary_key: :tests_id do |table|
      table.integer :duration
      table.boolean :passed
      table.integer :test_runs_id
      table.integer :scenarios_id
      table.integer :error_messages_id
    end
  end
end

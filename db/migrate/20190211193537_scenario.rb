class Scenario < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios, primary_key: :scenarios_id do |table|
      table.string :steps
      table.string :scenario_name
      table.string :scenario_description
      table.integer :features_id
      table.string :json_scenario_id
    end
  end
end

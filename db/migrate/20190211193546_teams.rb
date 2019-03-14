class Team < ActiveRecord::Migration[5.2]
  def change
    create_table :teams, primary_key: :teams_id do |tables|
      tables.string :team_name
    end
  end
end

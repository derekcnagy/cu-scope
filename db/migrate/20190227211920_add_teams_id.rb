class AddTeamsId < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :teams_id, :integer
    add_column :features, :teams_id, :integer
    add_column :notes, :teams_id, :integer
  end
end

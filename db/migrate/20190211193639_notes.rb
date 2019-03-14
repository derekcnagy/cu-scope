class Note < ActiveRecord::Migration[5.2]
  def change
    create_table :notes, primary_key: :notes_id do |table|
      table.string :note
      table.integer :scenarios_id
      table.integer :errors_id
      table.integer :tests_id
    end
  end
end

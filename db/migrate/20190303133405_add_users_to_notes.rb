class AddUsersToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :users_id, :integer
  end
end

class FixErrorMessageIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :notes, :errors_id, :error_messages_id
  end
end

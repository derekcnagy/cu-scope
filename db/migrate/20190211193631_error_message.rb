class ErrorMessage < ActiveRecord::Migration[5.2]
  def change
    create_table :error_messages, primary_key: :error_messages_id do |table|
      table.string :error_message
    end
  end
end

class User < ActiveRecord::Migration[5.2]
  def change
    create_table :Users, primary_key: :users_id do |table|
      table.string :user_name
      table.string :first_name
      table.string :last_name
      table.string :password_digest
      table.integer :teams_id
    end
  end
end

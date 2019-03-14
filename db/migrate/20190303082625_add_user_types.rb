class AddUserTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_types, primary_key: :user_types_id do |table|
      table.string :type_name
    end

    add_column :users, :user_types_id, :integer
  end
end

class Profile < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, primary_key: :profiles_id do |table|
      table.string :profile_name
    end
  end
end

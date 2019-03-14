class Feature < ActiveRecord::Migration[5.2]
  def change
    create_table :features, primary_key: :features_id do |table|
      table.string :feature_name
      table.string :feature_description
      table.string :json_feature_id
    end
  end
end

class ChangeBackToPassed < ActiveRecord::Migration[5.2]
  def change
    rename_column :individual_tests, :something, :passed
  end
end

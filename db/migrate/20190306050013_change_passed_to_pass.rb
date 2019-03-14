class ChangePassedToPass < ActiveRecord::Migration[5.2]
  def change
    rename_column :individual_tests, :passed, :pass
  end
end

class ChangePassAgain1 < ActiveRecord::Migration[5.2]
  def change
    rename_column :individual_tests, :did_it_pass, :something
  end
end

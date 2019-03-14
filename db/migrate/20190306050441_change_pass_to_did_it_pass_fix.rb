class ChangePassToDidItPassFix < ActiveRecord::Migration[5.2]
  def change
    rename_column :individual_tests, :pass, :did_it_pass
  end
end

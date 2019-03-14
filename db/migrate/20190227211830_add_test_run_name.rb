class AddTestRunName < ActiveRecord::Migration[5.2]
  def change
    add_column :test_runs, :test_run_name, :string
  end
end

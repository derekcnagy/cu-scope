class ErrorRecordingImproving < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_tests, :error_location, :string
    add_column :individual_tests, :full_error_message, :string
  end
end

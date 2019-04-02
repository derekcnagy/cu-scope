class NoteDates < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :date_created, :datetime
    add_column :notes, :last_date_invoked, :datetime
  end
end

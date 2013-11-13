class AddWDayToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :wday, :integer
  end
end

class AddHourToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :hour, :integer
  end
end

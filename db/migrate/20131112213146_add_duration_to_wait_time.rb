class AddDurationToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :duration, :time
  end
end

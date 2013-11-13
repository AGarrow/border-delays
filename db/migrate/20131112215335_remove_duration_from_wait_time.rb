class RemoveDurationFromWaitTime < ActiveRecord::Migration
  def up
    remove_column :wait_times, :duration
  end

  def down
    add_column :wait_times, :duration, :string
  end
end

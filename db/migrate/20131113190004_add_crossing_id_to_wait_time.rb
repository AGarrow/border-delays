class AddCrossingIdToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :crossing_id, :integer
  end
end

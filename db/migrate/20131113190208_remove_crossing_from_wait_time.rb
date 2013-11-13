class RemoveCrossingFromWaitTime < ActiveRecord::Migration
  def up
    remove_column :wait_times, :location
    remove_column :wait_times, :title
  end

  def down
    add_column :wait_times, :title, :string
    add_column :wait_times, :location, :string
  end
end

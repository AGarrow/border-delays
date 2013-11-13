class AddLocationToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :location, :string
  end
end

class AddBoundToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :bound, :string
  end
end

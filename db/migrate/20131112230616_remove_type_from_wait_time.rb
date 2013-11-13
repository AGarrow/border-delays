class RemoveTypeFromWaitTime < ActiveRecord::Migration
  def up
    remove_column :wait_times, :type
  end

  def down
    add_column :wait_times, :type, :string
  end
end

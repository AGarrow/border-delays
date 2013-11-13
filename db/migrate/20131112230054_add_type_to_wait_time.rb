class AddTypeToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :type, :string
  end
end

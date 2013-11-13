class AddDurationIntToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :duration, :integer
  end
end

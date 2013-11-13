class AddCommercialToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :commercial, :boolean
  end
end

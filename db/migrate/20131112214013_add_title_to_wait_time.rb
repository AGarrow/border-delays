class AddTitleToWaitTime < ActiveRecord::Migration
  def change
    add_column :wait_times, :title, :string
  end
end

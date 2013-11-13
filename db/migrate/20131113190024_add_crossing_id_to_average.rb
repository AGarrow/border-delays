class AddCrossingIdToAverage < ActiveRecord::Migration
  def change
    add_column :averages, :crossing_id, :integer
  end
end

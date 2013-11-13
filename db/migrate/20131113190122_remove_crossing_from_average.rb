class RemoveCrossingFromAverage < ActiveRecord::Migration
  def up
    remove_column :averages, :location
    remove_column :averages, :title
  end

  def down
    add_column :averages, :title, :string
    add_column :averages, :location, :string
  end
end

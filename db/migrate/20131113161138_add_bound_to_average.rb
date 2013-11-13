class AddBoundToAverage < ActiveRecord::Migration
  def change
    add_column :averages, :bound, :string
  end
end

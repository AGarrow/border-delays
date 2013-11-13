class AddTimeZoneToCrossing < ActiveRecord::Migration
  def change
    add_column :crossings, :time_zone, :string
  end
end

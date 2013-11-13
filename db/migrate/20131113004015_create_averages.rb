class CreateAverages < ActiveRecord::Migration
  def change
    create_table :averages do |t|
      t.integer :wday
      t.integer :hour
      t.string :title
      t.string :location
      t.integer :delay

      t.timestamps
    end
  end
end

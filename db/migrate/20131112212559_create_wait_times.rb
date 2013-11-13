class CreateWaitTimes < ActiveRecord::Migration
  def change
    create_table :wait_times do |t|

      t.timestamps
    end
  end
end

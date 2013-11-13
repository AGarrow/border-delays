class CreateCrossings < ActiveRecord::Migration
  def change
    create_table :crossings do |t|
      t.string :title
      t.string :location

      t.timestamps
    end
    add_index :crossings, :title
  end
end

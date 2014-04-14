class AddStateToCrossing < ActiveRecord::Migration
  def change
    add_column :crossings, :state, :string
  end
end

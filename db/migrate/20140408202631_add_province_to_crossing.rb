class AddProvinceToCrossing < ActiveRecord::Migration
  def change
    add_column :crossings, :province, :string
  end
end

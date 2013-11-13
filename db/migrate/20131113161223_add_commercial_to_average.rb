class AddCommercialToAverage < ActiveRecord::Migration
  def change
    add_column :averages, :commercial, :boolean
  end
end

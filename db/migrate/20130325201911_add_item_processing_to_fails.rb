class AddItemProcessingToFails < ActiveRecord::Migration
  def change
    add_column :fails, :item_processing, :boolean

  end
end

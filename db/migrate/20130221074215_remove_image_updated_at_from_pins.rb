class RemoveImageUpdatedAtFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :image_updated_at
      end

  def down
    add_column :pins, :image_updated_at, :datetime
  end
end

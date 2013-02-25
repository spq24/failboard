class RemoveImageFileSizeFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :image_file_size
      end

  def down
    add_column :pins, :image_file_size, :integer
  end
end

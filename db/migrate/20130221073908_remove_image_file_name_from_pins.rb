class RemoveImageFileNameFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :image_file_name
      end

  def down
    add_column :pins, :image_file_name, :string
  end
end

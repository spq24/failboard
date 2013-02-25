class RemoveImageContentTypeFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :image_content_type
      end

  def down
    add_column :pins, :image_content_type, :string
  end
end

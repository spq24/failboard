class AddAlbumIdToFails < ActiveRecord::Migration
  def change
    add_column :fails, :album_id, :integer

  end
end

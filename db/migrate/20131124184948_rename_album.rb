class RenameAlbum < ActiveRecord::Migration
  def change
    rename_table :album, :albums
  end
end
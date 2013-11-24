class RenameAlbums < ActiveRecord::Migration
  def change
    rename_table :albums, :album
  end
end
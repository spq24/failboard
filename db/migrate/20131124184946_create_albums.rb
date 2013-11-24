class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :user_id
      t.string :image
      t.string :image_url

      t.timestamps
    end
  end
end

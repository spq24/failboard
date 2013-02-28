class AddRemoteImageUrlToFails < ActiveRecord::Migration
  def change
    add_column :fails, :remote_image_url, :string

  end
end

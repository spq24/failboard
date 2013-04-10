class AddYoutubUrlToFails < ActiveRecord::Migration
  def change
    add_column :fails, :youtube_url, :string

  end
end

class AddPhotoToFails < ActiveRecord::Migration
  def change
    add_column :fails, :photo, :string

  end
end

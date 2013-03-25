class AddFileSizeToFails < ActiveRecord::Migration
  def change
    add_column :fails, :file_size, :integer

  end
end

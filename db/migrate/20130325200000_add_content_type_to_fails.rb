class AddContentTypeToFails < ActiveRecord::Migration
  def change
    add_column :fails, :content_type, :string

  end
end

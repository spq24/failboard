class AddStuffToFails < ActiveRecord::Migration
  def change
    add_column :fails, :zencoder_output_id, :string

    add_column :fails, :processed, :boolean

  end
end

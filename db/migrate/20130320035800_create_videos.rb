class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :attachment
      t.string :zencoder_output_id
      t.boolean :processed

      t.timestamps
    end
  end
end

class AddJobIdToFails < ActiveRecord::Migration
  def change
    add_column :fails, :job_id, :integer

  end
end

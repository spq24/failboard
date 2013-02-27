class AddFailTitleToFails < ActiveRecord::Migration
  def change
    add_column :fails, :fail_title, :string

  end
end

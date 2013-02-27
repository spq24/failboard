class ChangePinsToFails < ActiveRecord::Migration
    def change
        rename_table :pins, :fails
    end 
end

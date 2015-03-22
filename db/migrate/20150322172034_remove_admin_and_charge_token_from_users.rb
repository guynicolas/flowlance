class RemoveAdminAndChargeTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin 
    remove_column :users, :charge_token
  end
end

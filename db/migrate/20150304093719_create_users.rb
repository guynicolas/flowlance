class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :email, :password_digest, :charge_token
      t.boolean :admin, default: :false 
      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :description, :volume, :amount_due, :client_name, :due_date 
      t.timestamps
    end
  end
end

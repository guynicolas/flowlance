class Project < ActiveRecord::Base 
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :volume
  validates_presence_of :amount_due
  validates_presence_of :client_name
  belongs_to :user
end 
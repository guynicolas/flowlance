class User < ActiveRecord::Base 
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password 
  validates_uniqueness_of :email 
  has_secure_password 
  has_many :projects
end 

def admin?
  admin = true
end
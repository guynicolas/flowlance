class User < ActiveRecord::Base 
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password 
  validates_uniqueness_of :email 
  has_secure_password 
  has_many :projects
  
  before_create :generate_token 
  
  def admin?
    admin = true
  end

  def generate_token 
    self.token = SecureRandom.urlsafe_base64 
  end

end 
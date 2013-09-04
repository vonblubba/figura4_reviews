class User < ActiveRecord::Base
  has_many :reviews
  
  validates_presence_of :name, :password, :password_confirmation
  validates_uniqueness_of :name
  validates_length_of :password, :minimum => 5, :message => "should be at least 5 characters long"
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  require 'digest/sha1'

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  # 'password' is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def safe_delete
    transaction do
      destroy
      if User.count.zero?
        raise "Non posso cancellare l'ultimo utente!"
      end
    end
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "jappo" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
  

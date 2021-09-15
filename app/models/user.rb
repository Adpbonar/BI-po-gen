class User < ApplicationRecord
  has_many :pos
  encrypts :email
  blind_index :email

  validate :password_complexity

  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
    errors.add :password, 'Please use at least: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end
      
end

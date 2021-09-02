class User < ApplicationRecord
  has_many :pos
  encrypts :email
  blind_index :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

end

class User < ApplicationRecord
  has_many :pos
  encrypts :email
  blind_index :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def issued_by(user)
    if user.email.split('@').last == 'bonarinstitute.com'
      return "Issued by the Bonar Institute for Purposeful Leadership."
    else
      errors.add(:email, message: "not valid")
    end
  end
end

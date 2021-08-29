class User < ApplicationRecord
  has_many :pos
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def issued_by
    if current_user.email.split('@').last == 'bonarinstitute.com'
      return "Issued by the Bonar Institute for Purposeful Leadership."
    end
  end
end

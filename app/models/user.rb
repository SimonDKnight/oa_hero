class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :rememberable, :validatable, :database_authenticatable

  has_many :licenses, dependent: :destroy

  def password_required?
    false
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :favourites
  validates :username, :email, presence: true
  validates :username, length: { in: 3..20 }
  validates_uniqueness_of :username
end

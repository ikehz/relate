class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	       :confirmable, :lockable, :timeoutable, :omniauthable

  validates :username, presence: true, format: { with: /\A[0-9a-z_\-]+\z/ }, uniqueness: true
  validates :name, format: { with: /\A[A-Za-z ]*\z/ }
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	       :confirmable, :lockable, :timeoutable, :omniauthable

  # rely in Devise for user security
  #
  # TODO is this really a good idea?
  #
  # We probably need to modify Grant to work with column-level security so that
  # we can modify certain things as anonymous and not others
  grant(:find) { true }
  grant(:create, :update, :destroy) { true }
  # grant(:create, :update, :destroy) { |user, model, action| user == model }

  validates :username, presence: true, format: { with: /\A[0-9a-z_\-]+\z/ }, uniqueness: true
  validates :name, format: { with: /\A[A-Za-z ]*\z/ }
end

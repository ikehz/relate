class User < ActiveRecord::Base
  has_many :contacts, foreign_key: "owner_id", dependent: :destroy
  has_many :conversations, foreign_key: "owner_id", dependent: :destroy
  has_many :participants, foreign_key: "owner_id", dependent: :destroy
  has_many :tags, foreign_key: "owner_id", dependent: :destroy
  has_many :conversation_tags, foreign_key: "owner_id", dependent: :destroy

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	       :confirmable, :lockable, :timeoutable, :omniauthable

  validates :username, presence: true, format: { with: /\A[0-9a-z_\-]+\z/ }, uniqueness: true
end

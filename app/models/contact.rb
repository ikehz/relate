class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :conversations, through: :participants

  grant(:find, :create, :update, :destroy) { |user, model, action| model.user == user }

  validates :user, presence: true
  validates :name, presence: true
end

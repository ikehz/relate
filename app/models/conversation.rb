class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :contacts, through: :participations

  grant(:find, :create, :update, :destroy) { |user, model, action| model.user == user }

  validates :user, presence: true
end

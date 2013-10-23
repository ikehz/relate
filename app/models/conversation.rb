class Conversation < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :participants, dependent: :destroy
  has_many :contacts, through: :participants

  grant(:find, :create, :update, :destroy) { |user, model, action| model.owner == user }

  validates :owner, presence: true
end

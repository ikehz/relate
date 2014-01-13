class Conversation < ActiveRecord::Base
  include Owned

  has_many :participants, dependent: :destroy
  has_many :contacts, through: :participants
  has_many :conversation_tags, dependent: :destroy
  has_many :tags, through: :conversation_tags

  validates :description, presence: true
  validates :date, presence: true

  default_scope { order(date: :desc) }
end

class Conversation < ActiveRecord::Base
  include Owned

  has_many :participants, dependent: :destroy
  has_many :contacts, through: :participants
  has_and_belongs_to_many :tags

  validates :description, presence: true
  validates :date, presence: true

  default_scope { order(date: :desc) }
end

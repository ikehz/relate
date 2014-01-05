class Conversation < ActiveRecord::Base
  include Owned

  has_many :participants, dependent: :destroy
  has_many :contacts, through: :participants

  validates :description, presence: true
  validates :date, presence: true

  default_scope order(date: :desc)
end

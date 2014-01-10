class Contact < ActiveRecord::Base
  include Owned

  has_many :participants, dependent: :destroy
  has_many :conversations, through: :participants

  validates :name, presence: true

  default_scope { order(:name) }
end

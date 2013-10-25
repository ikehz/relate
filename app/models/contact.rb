class Contact < ActiveRecord::Base
  include Owned

  has_many :participants, dependent: :destroy
  has_many :conversations, through: :participants

  grant(:find, :create, :update, :destroy) { |user, model, action| model.owned_by? user }

  validates :name, presence: true
end

class Participant < ActiveRecord::Base
  include Owned

  belongs_to :contact
  belongs_to :conversation

  validates :contact, presence: true
  validates :conversation, presence: true

  # TODO is this if statements needed / reasonable?
  validates :conversation, uniqueness: { :scope => :contact, :message => "already has participant" }, if: "contact.present? and conversation.present?"
  # TODO is this if statements needed / reasonable?
  validates :contact, same_owner: { as: :conversation }, if: "contact.present? and conversation.present?"
end

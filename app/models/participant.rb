class Participant < ActiveRecord::Base
  include Owned

  belongs_to :contact
  belongs_to :conversation

  validates :contact, presence: true, same_owner: true
  validates :conversation, presence: true, same_owner: true

  # TODO is this if statements needed / reasonable?
  validates :conversation, uniqueness: { :scope => :contact, :message => "already has participant" }, if: "contact.present? and conversation.present?"
end

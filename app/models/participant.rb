class Participant < ActiveRecord::Base
  include Owned

  belongs_to :contact
  belongs_to :conversation

  grant(:find, :create, :update, :destroy) { |user, model, action| model.owned_by? user }

  validates :contact, presence: true
  validates :contact, same_owner_as_record: true, if: "contact.present?"
  validates :conversation, presence: true
  validates :conversation, same_owner_as_record: true, if: "conversation.present?"
end

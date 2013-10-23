class Participant < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :contact
  belongs_to :conversation

  grant(:find, :create, :update, :destroy) { |user, model, action| model.owner == user }

  validates :owner, presence: true
  validates :contact, presence: true
  validates :contact, same_owner_as_record: true, if: "contact.present?"
  validates :conversation, presence: true
  validates :conversation, same_owner_as_record: true, if: "conversation.present?"
end

class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  belongs_to :conversation

  grant(:find, :create, :update, :destroy) { |user, model, action| model.user == user }

  validates :user, presence: true
  validates :contact, presence: true
  validates :contact, same_user_as_record: true, if: "contact.present?"
  validates :conversation, presence: true
  validates :conversation, same_user_as_record: true, if: "conversation.present?"
end

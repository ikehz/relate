class Participant < ActiveRecord::Base
  belongs_to :contact
  belongs_to :conversation

  grant(:find, :create, :update, :destroy) { |user, model, action| model.conversation.owned_by? user }

  validates :contact, presence: true
  validates :conversation, presence: true
  validates :contact, same_owner: { as: :conversation }, if: "contact.present?"
end

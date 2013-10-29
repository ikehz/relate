class Participant < ActiveRecord::Base
  belongs_to :contact
  # XXX this inverse_of is a workaround until @wangjohn's PR 9522 is merged into stable:
  # http://github.com/rails/rails/pull/9522
  belongs_to :conversation, inverse_of: :participants

  grant(:find, :create, :update, :destroy) { |user, model, action| model.conversation.owned_by? user }

  validates :contact, presence: true
  validates :conversation, presence: true

  # TODO is this if statements needed / reasonable?
  #
  # XXX this isn't working, per @Empact's PR 11851:
  # http://github.com/rails/rails/pull/11851
  #
  # build a custom validator?
  validates :conversation, uniqueness: { :scope => :contact, :message => "already has participant" }, if: "contact.present? and conversation.present?"
  # TODO is this if statements needed / reasonable?
  validates :contact, same_owner: { as: :conversation }, if: "contact.present? and conversation.present?"
end

class Conversation < ActiveRecord::Base
  include Owned

  # XXX this inverse_of is a workaround until @wangjohn's PR 9522 is merged into stable
  has_many :participants, dependent: :destroy, inverse_of: :conversation
  has_many :contacts, through: :participants
  accepts_nested_attributes_for :participants, allow_destroy: true, reject_if: :all_blank

  grant(:find, :create, :update, :destroy) { |user, model, action| model.owned_by? user }

  validates :date, presence: true
end

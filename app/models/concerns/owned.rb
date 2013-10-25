module Owned
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, class_name: "User"
    validates :owner, presence: true
    scope :owned_by, lambda { |user| where(owner: user) }
  end

  def make_owned_by(user)
    owner = user
  end

  def owned_by?(user)
    owner == user
  end
end

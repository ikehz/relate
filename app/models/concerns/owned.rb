module Owned
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, class_name: "User"
    validates :owner, presence: true
  end
end

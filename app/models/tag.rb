class Tag < ActiveRecord::Base
  include Owned

  has_and_belongs_to_many :conversations

  validates :name, presence: true, uniqueness: { scope: :owner }
end

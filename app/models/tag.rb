class Tag < ActiveRecord::Base
  include Owned

  validates :name, presence: true
end

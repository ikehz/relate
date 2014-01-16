class Organization < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :title, presence: true
end

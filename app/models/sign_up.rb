class SignUp < ActiveRecord::Base
  grant(:create) { true }
  grant(:find, :update, :destroy) { false }

  validates :email, presence: true, format: { with: Devise.email_regexp }, uniqueness: true
  validates_inclusion_of :build, in: [true, false]
  validates_inclusion_of :mobilize, in: [true, false]
  validates_inclusion_of :share, in: [true, false]
end

class SignUp < ActiveRecord::Base
  grant(:create) { true }
  grant(:find, :update, :destroy) { false }

  validates :email, presence: true, format: { with: Devise.email_regexp }, uniqueness: true

  validates_inclusion_of :build, in: [-1, 0, 1], message: "Please tell us what you think!"
  validates_inclusion_of :mobilize, in: [-1, 0, 1], message: "Please tell us what you think!"
  validates_inclusion_of :share, in: [-1, 0, 1], message: "Please tell us what you think!"
end

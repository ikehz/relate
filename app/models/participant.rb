class Participant < ActiveRecord::Base
  include Owned

  belongs_to :contact
  belongs_to :conversation

  validates :contact, presence: true, same_owner: true
  validates :conversation, presence: true, same_owner: true

  validates :contact, uniqueness: { :scope => :conversation }, allow_blank: true

  def contact_name
    contact.name
  end
end

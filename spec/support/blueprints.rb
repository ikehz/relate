require 'machinist/active_record'

User.blueprint do |user|
  email  { "user#{sn}@u.com" }
  username { "user#{sn}" }
  name { "User Person #{sn}" }
  password  { "password#{sn}" }
  confirmed_at { Time.now }
end

Conversation.blueprint do |conversation|
  owner
  date { Date.today }
  notes { "Some notes #{sn}" }
end

Contact.blueprint do |contact|
  owner
  name { "Contact Person #{sn}" }
end

# NOTE this blueprint will create a record whose contact's owner is the
# same as the record's conversation's owner.  This does NOT work in reverse.
Participant.blueprint do |participant|
  u = User.make
  conversation { Conversation.make(owner: u) }
  contact { Contact.make(owner: u) }
end

SignUp.blueprint do |sign_up|
  email  { "sign_up#{sn}@s.com" }
  build  { false }
  mobilize  { false }
  share  { false }
end

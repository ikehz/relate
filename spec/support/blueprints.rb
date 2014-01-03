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

Participant.blueprint do |participant|
  owner
  conversation { Conversation.make(owner: object.owner) }
  contact { Contact.make(owner: object.owner) }
end

require 'machinist/active_record'

User.blueprint do |user|
  email  { "user#{sn}@u.com" }
  username { "user#{sn}" }
  name { "User Person #{sn}" }
  password  { "password#{sn}" }
  confirmed_at { Time.now }
end

Conversation.blueprint do |conversation|
  description { "Conversation #{sn}" }
  owner
  date { Date.today }
  notes { "Some *awesome* notes." }
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

Tag.blueprint do |tag|
  owner
  name { "Tag #{sn}" }
end

ConversationTag.blueprint do |conversation_tag|
  owner
  conversation { Conversation.make(owner: object.owner) }
  tag { Tag.make(owner: object.owner) }
end

require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do |user|
  email  { "user#{sn}@example.com" }
  username { "user#{sn}" }
  name { "User Person" }
  password  { "password#{sn}" }
  confirmed_at { Time.now }
end

Conversation.blueprint do |conversation|
  owner
  date { Date.today }
  notes { "Some notes" }
end

Contact.blueprint do |contact|
  owner
  name { "Contact Person" }
end

# NOTE this blueprint will create a record whose contact's owner is the
# same as the record's conversation's owner.  This does NOT work in reverse.
Participant.blueprint do |participant|
  conversation { Conversation.make }
  contact { Contact.make(owner: object.conversation.owner) }
end

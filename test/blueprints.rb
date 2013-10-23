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
  notes { "Some notes" }
end

Contact.blueprint do |contact|
  owner
  name { "Contact Person" }
end

Participant.blueprint do |participant|
  owner
  contact { Contact.make(owner: object.owner) }
  conversation { Conversation.make(owner: object.owner) }
end

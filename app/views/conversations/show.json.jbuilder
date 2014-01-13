json.extract! @conversation, :description, :date, :notes, :created_at, :updated_at
json.tags @conversation.conversation_tags do |conversation_tag|
  json.extract! conversation_tag, :name
  json.url tag_url(conversation_tag, format: :json)
end
json.participants @conversation.participants do |participant|
  json.extract! participant, :name
  json.url contact_url(participant, format: :json)
end

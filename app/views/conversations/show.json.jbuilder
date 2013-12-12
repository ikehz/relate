json.extract! @conversation, :date, :notes, :created_at, :updated_at
json.participants @conversation.participants do |participant|
  json.extract! participant, :name
  json.url contact_url(participant, format: :json)
end

json.extract! @contact, :name, :created_at, :updated_at
json.conversations @contact.conversations do |conversation|
  json.extract! conversation, :date, :notes
  json.url conversation_url(conversation, format: :json)
end

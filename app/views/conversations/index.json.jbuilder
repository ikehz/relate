json.array!(@conversations) do |conversation|
  json.extract! conversation, :notes
  json.url conversation_url(conversation, format: :json)
end

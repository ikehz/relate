json.array!(@conversations) do |conversation|
  json.extract! conversation, :date, :notes
  json.url conversation_url(conversation, format: :json)
end

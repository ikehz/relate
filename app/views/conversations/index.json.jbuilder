json.array!(@conversations) do |conversation|
  json.extract! conversation, :date, :description
  json.url conversation_url(conversation, format: :json)
end

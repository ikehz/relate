json.array!(@conversations) do |conversation|
  json.extract! conversation, :user_id, :notes
  json.url conversation_url(conversation, format: :json)
end

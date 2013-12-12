json.array!(@contacts) do |contact|
  json.extract! contact, :name, :created_at, :updated_at
  json.url contact_url(contact, format: :json)
end

json.array!(@tags) do |tag|
  json.extract! tag, :name, :created_at, :updated_at
  json.url tag_url(tag, format: :json)
end

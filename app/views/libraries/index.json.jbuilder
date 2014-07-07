json.array!(@libraries) do |library|
  json.extract! library, :id, :name, :url
  json.url library_url(library, format: :json)
end

json.array!(@brackets) do |bracket|
  json.extract! bracket, :id
  json.url bracket_url(bracket, format: :json)
end

json.array!(@regularcontests) do |regularcontest|
  json.extract! regularcontest, :id
  json.url regularcontest_url(regularcontest, format: :json)
end

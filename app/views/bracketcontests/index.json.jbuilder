json.array!(@bracketcontests) do |bracketcontest|
  json.extract! bracketcontest, :id
  json.url bracketcontest_url(bracketcontest, format: :json)
end

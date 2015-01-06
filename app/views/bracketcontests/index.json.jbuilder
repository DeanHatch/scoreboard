json.array!(@bracketcontests) do |bracketcontest|
  json.extract! bracketcontest, :id, :date, :time, :venue_id, :status
  json.url bracketcontest_url(bracketcontest, format: :json)
end

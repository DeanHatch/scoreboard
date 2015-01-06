json.array!(@contests) do |contest|
  json.extract! contest, :id, :date, :time, :venue_id, :status
  json.url contest_url(contest, format: :json)
end

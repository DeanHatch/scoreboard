json.array!(@regularcontestants) do |regularcontestant|
  json.extract! regularcontestant, :id, :contest_id, :contest_type, :homeaway, :team_id, :score, :forfeit
  json.url regularcontestant_url(regularcontestant, format: :json)
end

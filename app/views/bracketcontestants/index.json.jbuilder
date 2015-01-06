json.array!(@bracketcontestants) do |bracketcontestant|
  json.extract! bracketcontestant, :id, :contest_id, :contest_type, :homeaway, :team_id, :score, :forfeit, :contestanttype, :seeding
  json.url bracketcontestant_url(bracketcontestant, format: :json)
end

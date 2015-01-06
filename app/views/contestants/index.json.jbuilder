json.array!(@contestants) do |contestant|
  json.extract! contestant, :id, :contest_id, :contest_type, :homeaway, :team_id, :score, :forfeit, :contestanttype, :seeding, :bracketcontest_id, :grouping_id, :place
  json.url contestant_url(contestant, format: :json)
end

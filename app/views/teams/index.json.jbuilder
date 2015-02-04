json.array!(@teams) do |team|
  json.extract! team, :id, :competition_id, :name, :grouping_id
  json.url team_url(team, format: :json)
end

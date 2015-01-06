json.array!(@competitions) do |competition|
  json.extract! competition, :id, :name, :sport, :variety, :poolgroupseason, :keepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore
  json.url competition_url(competition, format: :json)
end

json.array!(@competitions) do |competition|
  json.extract! competition, :id, :name, :sport, :variety, :poolgroupseason, :poolgroupseasonlabel, :playoffbracket, :playoffbracketlabel, :kepscores, :winpoints, :drawpoints, :losspoints, :forfeitpoints, :forfeitwinscore, :forfeitlossscore
  json.url competition_url(competition, format: :json)
end

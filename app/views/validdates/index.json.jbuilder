json.array!(@validdates) do |validdate|
  json.extract! validdate, :id, :gamedate, :competition_id
  json.url validdate_url(validdate, format: :json)
end

json.array!(@validdates) do |validdate|
  json.extract! validdate, :id, :gamedate
  json.url validdate_url(validdate, format: :json)
end

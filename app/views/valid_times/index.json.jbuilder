json.array!(@valid_times) do |valid_time|
  json.extract! valid_time, :id, :competition_id, :grouping_id, :venue_id, :from_time, :to_time
  json.url valid_time_url(valid_time, format: :json)
end

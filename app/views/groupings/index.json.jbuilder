json.array!(@groupings) do |grouping|
  json.extract! grouping, :id, :groupingname, :grouping_id
  json.url grouping_url(grouping, format: :json)
end

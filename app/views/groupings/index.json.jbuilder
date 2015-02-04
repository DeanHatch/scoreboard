json.array!(@groupings) do |grouping|
  json.extract! grouping, :id, :competition_id, :name, :parent_id
  json.url grouping_url(grouping, format: :json)
end

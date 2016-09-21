json.array!(@credits) do |credit|
  json.extract! credit, :id, :string
  json.url credit_url(credit, format: :json)
end

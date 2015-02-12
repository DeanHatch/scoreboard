json.array!(@customers) do |customer|
  json.extract! customer, :id, :userid, :hashed_password, :salt
  json.url customer_url(customer, format: :json)
end

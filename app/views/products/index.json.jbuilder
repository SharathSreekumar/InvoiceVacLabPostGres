json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :rate
  json.url product_url(product, format: :json)
end

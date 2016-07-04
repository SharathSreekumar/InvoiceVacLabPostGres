json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :customer_name, :customer_phone, :customer_email, :invoice, :invoice_date, :product, :rate, :quantity, :amount
  json.url invoice_url(invoice, format: :json)
end

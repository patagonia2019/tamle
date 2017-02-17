json.extract! invoice, :id, :billed, :at_date, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)

json.extract! transaction, :id, :user_id, :billed, :at_date, :concept, :amount, :is_credit, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

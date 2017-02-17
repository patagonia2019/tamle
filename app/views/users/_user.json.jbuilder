json.extract! user, :id, :name, :email, :created_at, :updated_at, :address, :catastro, :phone, :mobile
json.url user_url(user, format: :json)

json.extract! user, :id, :email, :password_digest, :confirmed_at, :lastname, :firstname, :address, :username, :created_at, :updated_at
json.url user_url(user, format: :json)

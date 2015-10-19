json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :phone, :verified, :verificationCode, :venmoId
  json.url user_url(user, format: :json)
end

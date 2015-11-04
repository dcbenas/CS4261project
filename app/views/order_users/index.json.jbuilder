json.array!(@order_users) do |order_user|
  json.extract! order_user, :id, :username, :orderID, :listOfItems
  json.url order_user_url(order_user, format: :json)
end

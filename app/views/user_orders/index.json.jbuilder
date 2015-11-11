json.array!(@user_orders) do |user_order|
  json.extract! user_order, :id, :Username, :OrderID, :Listofitems, :Total
  json.url user_order_url(user_order, format: :json)
end

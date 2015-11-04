json.array!(@orders) do |order|
  json.extract! order, :id, :primaryUser, :location, :isPlaced, :reqd_total, :merchantID
  json.url order_url(order, format: :json)
end

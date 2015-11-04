class OrdersController < ApplicationController

	def merchant_search
		client = Delivery::Client.new('MTExNTBjNTgyOGQ0NTFiOTc0ZWI1MTg1MGQ3NmYxYjE3', { :base_uri => 'http://sandbox.delivery.com' })
		
		result = client.search(params["location"])
		results_hash = {}

		result.merchants.each do |m|
			if m.summary.type_label == "Restaurant"
				results_hash[m.id] = {
					name: m.summary.name,
					address: "#{m.location.street}, #{m.location.city}, #{m.location.state}",
					distance: m.location.distance,
					cuisine: m.summary.cuisines[0]
				}
			end
		end

		render json: results_hash
	end

end

class OrdersController < ApplicationController

	def merchant_search
		client = Delivery::Client.new 'NDhkNDYyZTBjOWYwOTMwYmZmNDQyNmY0ZmI5NDdlMzZh'
		
		result = client.search(params["location"])
		results_hash = {}

		result.merchants.each do |m|
			if m.summary.type_label == "Restaurant"
				results_hash[m.id] = {
					name: m.summary.name,
					address: "#{m.location.street}, #{m.location.city}, #{m.location.state}",
					distance: m.location.distance,
					cuisine: m.summary.cuisines
				}
			end
		end

		render json: results_hash
	end

end

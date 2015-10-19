class OrdersController < ApplicationController

	def merchant_search
		client = Delivery::Client.new 'x'
		
		result = client.search(params["location"])
		results_hash = {}

		result.merchants.each do |m|
			results_hash[m.id] = {
				name: m.summary.name,
				address: "#{m.location.street}, #{m.location.city}, #{m.location.state}"
			}
		end

		render json: results_hash
	end

end

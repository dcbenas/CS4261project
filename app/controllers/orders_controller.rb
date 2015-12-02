class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

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
  # For Location Search endpoint. Given user location, map to every other order and append GMaps distance
  def location_search
  	user_location = params["user_location"]
  	destinations = []

  	Order.all.each do |curr|
  		destinations.push(curr.location)
  	end

  	url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + user_location + "&mode=walking&key=AIzaSyCjFOYfjhdZJW8X1yQc-E9T9et5nd-BZBc&destinations=" + destinations.join("|")
  	response = HTTParty.get(url)

  	distanced_orders = []
  	counter = 0

  	Order.all.each do |order|
      distance = response['rows'][0]['elements'][counter]['distance']['value']
  		if !order.isPlaced and distance < 3218 # replace this with find_by
        order_total = 0
        UserOrder.where("OrderID = #{order.id}").each do |order|
          order_total = order_total + order['Total'].to_f
        end
  			distanced_orders.push(
  				{
  					id: order.id,
  					location: order.location,
  					reqd_total: order.reqd_total,
            order_total: order_total,
  					merchantID: order.merchantID,
  					distance: distance
  				}
  			)
  		end
  		counter = counter + 1
  	end

  	render json: distanced_orders
  end

  def minion_search
    userID = params["fbid"]
    result = {}

    if Order.where(primaryUser: userID).count > 0
      minions = []
      currentOrder = Order.where(primaryUser: userID).first

      UserOrder.where(OrderID: currentOrder.id).each do |userOrder|
        User.where(email: userOrder.Username).each do |u|
          minions.push({
            name: u.name,
            phone: u.phone,
            venmoID: u.venmoId,
            listOfItems: userOrder.Listofitems,
            total: userOrder.Total
          })
        end
      end  

      result = {
        orderID: currentOrder.id,
        isPlaced: currentOrder.isPlaced,
        merchantID: currentOrder.merchantID,
        minions: minions
      }    
    end

    render json: result
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:primaryUser, :location, :isPlaced, :reqd_total, :merchantID)
    end
end

class OrderUsersController < ApplicationController
  before_action :set_order_user, only: [:show, :edit, :update, :destroy]

  # GET /order_users
  # GET /order_users.json
  def index
    @order_users = OrderUser.all
  end

  # GET /order_users/1
  # GET /order_users/1.json
  def show
  end

  # GET /order_users/new
  def new
    @order_user = OrderUser.new
  end

  # GET /order_users/1/edit
  def edit
  end

  # POST /order_users
  # POST /order_users.json
  def create
    @order_user = OrderUser.new(order_user_params)

    respond_to do |format|
      if @order_user.save
        format.html { redirect_to @order_user, notice: 'Order user was successfully created.' }
        format.json { render :show, status: :created, location: @order_user }
      else
        format.html { render :new }
        format.json { render json: @order_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_users/1
  # PATCH/PUT /order_users/1.json
  def update
    respond_to do |format|
      if @order_user.update(order_user_params)
        format.html { redirect_to @order_user, notice: 'Order user was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_user }
      else
        format.html { render :edit }
        format.json { render json: @order_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_users/1
  # DELETE /order_users/1.json
  def destroy
    @order_user.destroy
    respond_to do |format|
      format.html { redirect_to order_users_url, notice: 'Order user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_user
      @order_user = OrderUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_user_params
      params.require(:order_user).permit(:username, :orderID, :listOfItems)
    end
end

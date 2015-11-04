require 'test_helper'

class OrderUsersControllerTest < ActionController::TestCase
  setup do
    @order_user = order_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_user" do
    assert_difference('OrderUser.count') do
      post :create, order_user: { listOfItems: @order_user.listOfItems, orderID: @order_user.orderID, username: @order_user.username }
    end

    assert_redirected_to order_user_path(assigns(:order_user))
  end

  test "should show order_user" do
    get :show, id: @order_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_user
    assert_response :success
  end

  test "should update order_user" do
    patch :update, id: @order_user, order_user: { listOfItems: @order_user.listOfItems, orderID: @order_user.orderID, username: @order_user.username }
    assert_redirected_to order_user_path(assigns(:order_user))
  end

  test "should destroy order_user" do
    assert_difference('OrderUser.count', -1) do
      delete :destroy, id: @order_user
    end

    assert_redirected_to order_users_path
  end
end

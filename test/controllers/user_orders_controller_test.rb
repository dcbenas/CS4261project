require 'test_helper'

class UserOrdersControllerTest < ActionController::TestCase
  setup do
    @user_order = user_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_order" do
    assert_difference('UserOrder.count') do
      post :create, user_order: { Listofitems: @user_order.Listofitems, OrderID: @user_order.OrderID, Total: @user_order.Total, Username: @user_order.Username }
    end

    assert_redirected_to user_order_path(assigns(:user_order))
  end

  test "should show user_order" do
    get :show, id: @user_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_order
    assert_response :success
  end

  test "should update user_order" do
    patch :update, id: @user_order, user_order: { Listofitems: @user_order.Listofitems, OrderID: @user_order.OrderID, Total: @user_order.Total, Username: @user_order.Username }
    assert_redirected_to user_order_path(assigns(:user_order))
  end

  test "should destroy user_order" do
    assert_difference('UserOrder.count', -1) do
      delete :destroy, id: @user_order
    end

    assert_redirected_to user_orders_path
  end
end

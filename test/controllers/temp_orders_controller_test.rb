require 'test_helper'

class TempOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temp_order = temp_orders(:one)
  end

  test "should get index" do
    get temp_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_temp_order_url
    assert_response :success
  end

  test "should create temp_order" do
    assert_difference('TempOrder.count') do
      post temp_orders_url, params: { temp_order: { table_id: @temp_order.table_id, user_id: @temp_order.user_id } }
    end

    assert_redirected_to temp_order_url(TempOrder.last)
  end

  test "should show temp_order" do
    get temp_order_url(@temp_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_temp_order_url(@temp_order)
    assert_response :success
  end

  test "should update temp_order" do
    patch temp_order_url(@temp_order), params: { temp_order: { table_id: @temp_order.table_id, user_id: @temp_order.user_id } }
    assert_redirected_to temp_order_url(@temp_order)
  end

  test "should destroy temp_order" do
    assert_difference('TempOrder.count', -1) do
      delete temp_order_url(@temp_order)
    end

    assert_redirected_to temp_orders_url
  end
end

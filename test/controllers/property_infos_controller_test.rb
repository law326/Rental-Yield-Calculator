require 'test_helper'

class PropertyInfosControllerTest < ActionController::TestCase
  setup do
    @property_info = property_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_info" do
    assert_difference('PropertyInfo.count') do
      post :create, property_info: { email: @property_info.email, phone_number: @property_info.phone_number, postcode: @property_info.postcode, property_cost: @property_info.property_cost, rent_income: @property_info.rent_income, rental_period_type_id: @property_info.rental_period_type_id }
    end

    assert_redirected_to property_info_path(assigns(:property_info))
  end

  test "should show property_info" do
    get :show, id: @property_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_info
    assert_response :success
  end

  test "should update property_info" do
    patch :update, id: @property_info, property_info: { email: @property_info.email, phone_number: @property_info.phone_number, postcode: @property_info.postcode, property_cost: @property_info.property_cost, rent_income: @property_info.rent_income, rental_period_type_id: @property_info.rental_period_type_id }
    assert_redirected_to property_info_path(assigns(:property_info))
  end

  test "should destroy property_info" do
    assert_difference('PropertyInfo.count', -1) do
      delete :destroy, id: @property_info
    end

    assert_redirected_to property_infos_path
  end
end

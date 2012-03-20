require 'test_helper'

class PageTempsControllerTest < ActionController::TestCase
  setup do
    @page_temp = page_temps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_temps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_temp" do
    assert_difference('PageTemp.count') do
      post :create, :page_temp => @page_temp.attributes
    end

    assert_redirected_to page_temp_path(assigns(:page_temp))
  end

  test "should show page_temp" do
    get :show, :id => @page_temp.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @page_temp.to_param
    assert_response :success
  end

  test "should update page_temp" do
    put :update, :id => @page_temp.to_param, :page_temp => @page_temp.attributes
    assert_redirected_to page_temp_path(assigns(:page_temp))
  end

  test "should destroy page_temp" do
    assert_difference('PageTemp.count', -1) do
      delete :destroy, :id => @page_temp.to_param
    end

    assert_redirected_to page_temps_path
  end
end

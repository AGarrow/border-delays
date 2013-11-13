require 'test_helper'

class WaitTimesControllerTest < ActionController::TestCase
  setup do
    @wait_time = wait_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wait_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wait_time" do
    assert_difference('WaitTime.count') do
      post :create, wait_time: {  }
    end

    assert_redirected_to wait_time_path(assigns(:wait_time))
  end

  test "should show wait_time" do
    get :show, id: @wait_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wait_time
    assert_response :success
  end

  test "should update wait_time" do
    put :update, id: @wait_time, wait_time: {  }
    assert_redirected_to wait_time_path(assigns(:wait_time))
  end

  test "should destroy wait_time" do
    assert_difference('WaitTime.count', -1) do
      delete :destroy, id: @wait_time
    end

    assert_redirected_to wait_times_path
  end
end

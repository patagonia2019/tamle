require 'test_helper'

class MeditionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medition = meditions(:one)
  end

  test "should get index" do
    get meditions_url
    assert_response :success
  end

  test "should get new" do
    get new_medition_url
    assert_response :success
  end

  test "should create medition" do
    assert_difference('Medition.count') do
      post meditions_url, params: { medition: { at_date: @medition.at_date, measure: @medition.measure, user_id: @medition.user_id } }
    end

    assert_redirected_to medition_url(Medition.last)
  end

  test "should show medition" do
    get medition_url(@medition)
    assert_response :success
  end

  test "should get edit" do
    get edit_medition_url(@medition)
    assert_response :success
  end

  test "should update medition" do
    patch medition_url(@medition), params: { medition: { at_date: @medition.at_date, measure: @medition.measure, user_id: @medition.user_id } }
    assert_redirected_to medition_url(@medition)
  end

  test "should destroy medition" do
    assert_difference('Medition.count', -1) do
      delete medition_url(@medition)
    end

    assert_redirected_to meditions_url
  end
end

require 'test_helper'

class ConsumesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consume = consumes(:one)
  end

  test "should get index" do
    get consumes_url
    assert_response :success
  end

  test "should get new" do
    get new_consume_url
    assert_response :success
  end

  test "should create consume" do
    assert_difference('Consume.count') do
      post consumes_url, params: { consume: { at_date: @consume.at_date, exceedance_m3: @consume.exceedance_m3, exceedance_m3_amount: @consume.exceedance_m3_amount, water_fix_consume_amount: @consume.water_fix_consume_amount, water_provision_amount: @consume.water_provision_amount } }
    end

    assert_redirected_to consume_url(Consume.last)
  end

  test "should show consume" do
    get consume_url(@consume)
    assert_response :success
  end

  test "should get edit" do
    get edit_consume_url(@consume)
    assert_response :success
  end

  test "should update consume" do
    patch consume_url(@consume), params: { consume: { at_date: @consume.at_date, exceedance_m3: @consume.exceedance_m3, exceedance_m3_amount: @consume.exceedance_m3_amount, water_fix_consume_amount: @consume.water_fix_consume_amount, water_provision_amount: @consume.water_provision_amount } }
    assert_redirected_to consume_url(@consume)
  end

  test "should destroy consume" do
    assert_difference('Consume.count', -1) do
      delete consume_url(@consume)
    end

    assert_redirected_to consumes_url
  end
end

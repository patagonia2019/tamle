require 'test_helper'

class EmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emission = emissions(:one)
  end

  test "should get index" do
    get emissions_url
    assert_response :success
  end

  test "should get new" do
    get new_emission_url
    assert_response :success
  end

  test "should create emission" do
    assert_difference('Emission.count') do
      post emissions_url, params: { emission: { at_emission_date: @emission.at_emission_date, balance_amount: @emission.balance_amount, balance_previous_amount: @emission.balance_previous_amount, balance_previous_date: @emission.balance_previous_date, ceb_amount: @emission.ceb_amount, ceb_date: @emission.ceb_date, consume_id: @emission.consume_id, exceedance_amount: @emission.exceedance_amount, exceedance_m3: @emission.exceedance_m3, medition_id: @emission.medition_id, payment_amount: @emission.payment_amount, payment_date: @emission.payment_date, previous_medition_id: @emission.previous_medition_id, social_quote_amount: @emission.social_quote_amount, water_consumed: @emission.water_consumed, water_measure: @emission.water_measure, water_previous_measure: @emission.water_previous_measure } }
    end

    assert_redirected_to emission_url(Emission.last)
  end

  test "should show emission" do
    get emission_url(@emission)
    assert_response :success
  end

  test "should get edit" do
    get edit_emission_url(@emission)
    assert_response :success
  end

  test "should update emission" do
    patch emission_url(@emission), params: { emission: { at_emission_date: @emission.at_emission_date, balance_amount: @emission.balance_amount, balance_previous_amount: @emission.balance_previous_amount, balance_previous_date: @emission.balance_previous_date, ceb_amount: @emission.ceb_amount, ceb_date: @emission.ceb_date, consume_id: @emission.consume_id, exceedance_amount: @emission.exceedance_amount, exceedance_m3: @emission.exceedance_m3, medition_id: @emission.medition_id, payment_amount: @emission.payment_amount, payment_date: @emission.payment_date, previous_medition_id: @emission.previous_medition_id, social_quote_amount: @emission.social_quote_amount, water_consumed: @emission.water_consumed, water_measure: @emission.water_measure, water_previous_measure: @emission.water_previous_measure } }
    assert_redirected_to emission_url(@emission)
  end

  test "should destroy emission" do
    assert_difference('Emission.count', -1) do
      delete emission_url(@emission)
    end

    assert_redirected_to emissions_url
  end
end

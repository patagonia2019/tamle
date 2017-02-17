module ConsumesHelper
  def consumeInfo()
    consume = Consume.last
  end

  def consumeSocialQuoteWithCurrency()
    number_to_currency(consumeInfo().social_quote_amount, unit: "$", format:"%u %n", precision:0)
  end

  def consumeUserExceedance()
    (consumeInfo().exceedance_m3 / consumeInfo().number_of_members).ceil
  end

  def consumeUserExceedanceAmount()
    consumeInfo().exceedance_m3_amount
  end

  def consumeTotalAmountWithCurrency()
    number_to_currency(consumeTotalAmount(), unit: "$", format:"%u %n", precision:0)
  end

  def consumeTotalAmount()
    consumeInfo().water_provision_amount + consumeInfo().water_fix_consume_amount
  end

  def consumeWaterProvisionAmountWithCurrency()
    number_to_currency(consumeInfo().water_provision_amount, unit: "$", format:"%u %n", precision:0)
  end

  def consumeWaterFixConsumeAmountWithCurrency()
    number_to_currency(consumeInfo().water_fix_consume_amount, unit: "$", format:"%u %n", precision:0)
  end

end

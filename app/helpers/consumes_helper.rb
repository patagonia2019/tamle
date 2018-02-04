module ConsumesHelper
  def consumeInfo(at_date = nil)
    if at_date != nil
    	consume = Consume.where(["at_date < ?", at_date]).last
    else
    	consume = Consume.last
    end
  end

  def consumeSocialQuoteWithCurrency(at_date = nil)
    number_to_currency(consumeInfo(at_date).social_quote_amount, unit: "$", format:"%u %n", precision:0)
  end

  def consumeUserExceedance(at_date = nil)
    (consumeInfo(at_date).exceedance_m3 / consumeInfo(at_date).number_of_members).ceil
  end

  def consumeUserExceedanceAmount(at_date = nil)
    consumeInfo(at_date).exceedance_m3_amount
  end

  def consumeTotalAmountWithCurrency(at_date = nil)
    number_to_currency(consumeTotalAmount(at_date), unit: "$", format:"%u %n", precision:0)
  end

  def consumeTotalAmount(at_date = nil)
    consumeInfo(at_date).water_provision_amount + consumeInfo(at_date).water_fix_consume_amount
  end

  def consumeWaterProvisionAmountWithCurrency(at_date = nil)
    number_to_currency(consumeInfo(at_date).water_provision_amount, unit: "$", format:"%u %n", precision:0)
  end

  def consumeWaterFixConsumeAmountWithCurrency(at_date = nil)
    number_to_currency(consumeInfo(at_date).water_fix_consume_amount, unit: "$", format:"%u %n", precision:0)
  end

end

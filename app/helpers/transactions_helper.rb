module TransactionsHelper

  def transactionBalanceWithCurrency(user_id = nil, at_date = nil)
      balance = 0
      if user_id == nil
        balance = transactionBalance(at_date)
      else
        balance = transactionBalanceByUser(user_id, at_date)
      end
      number_to_currency(balance, unit: "$", format:"%u %n", precision:2)
  end

  def transactionPagosSumWithCurrency(user_id = nil, at_date = nil)
      amount = 0
      if user_id == nil
        amount = transactionPagosSum()
      else
        amount = transactionPagosSumByUser(user_id, at_date)
      end
      number_to_currency(amount, unit: "$", format:"%u %n", precision:2)
  end

  def transactionCobrosSumWithCurrency(user_id = nil, at_date = nil)
      amount = 0
      if user_id == nil
        amount = transactionCobrosSum()
      else
        amount = transactionCobrosSumByUser(user_id, at_date)
      end
      number_to_currency(amount, unit: "$", format:"%u %n", precision:2)
  end

  def transactionBalance(at_date)
    transactionPagosSum(at_date) - transactionCobrosSum(at_date)
  end

  def transactionBalanceByUser(user_id, at_date)
    transactionPagosSumByUser(user_id, at_date) - transactionCobrosSumByUser(user_id, at_date)
  end

  def transactionPagosSum(at_date = nil)
    if at_date == nil
    	Transaction.where(:is_credit => true).sum(:amount)
    else
    	Transaction.where(:is_credit => true).where(["at_date <= ?", at_date.end_of_day]).sum(:amount)
    end
  end

  def transactionCobrosSum(at_date = nil)
    if at_date == nil
    	Transaction.where(:is_credit => false).sum(:amount)
    else
    	Transaction.where(:is_credit => false).where(["at_date <= ?", at_date.end_of_day]).sum(:amount)
    end
  end

  def transactionPagosSumByUser(user_id, at_date)
    if at_date == nil
   	Transaction.where(:is_credit => true, :user_id => user_id).sum(:amount)
    else
    	Transaction.where(:is_credit => true, :user_id => user_id).where(["at_date <= ?", at_date.end_of_day]).sum(:amount)
    end
  end

  def transactionCobrosSumByUser(user_id, at_date)
    if at_date == nil
   	Transaction.where(:is_credit => false, :user_id => user_id).sum(:amount)
    else
    	Transaction.where(:is_credit => false, :user_id => user_id).where(["at_date <= ?", at_date.end_of_day]).sum(:amount)
    end
  end

  def transactionCurrentMonthYear()
    transactionCurrent().at_date.strftime("%b-%Y")
  end


  def transactionByDateAndUserInvoiceAmountWithCurrency(at_date, user_id)
    number_to_currency(transactionByDateAndUserInvoiceAmount(at_date, user_id), unit: "$", format:"%u %n", precision:0)
  end

  def transactionByDateAndUserInvoiceAmount(at_date, user_id)
    transactionByDateAndUserInvoice(at_date, user_id).amount
  end

  def transactionByDateAndUserInvoice(at_date, user_id)
    Transaction.where(["at_date between ? and ? and user_id = ?", at_date.beginning_of_month, at_date.end_of_month, user_id]).first
  end

  def transactionUntilDateAndUserInvoice(at_date, user_id)
    Transaction.where(["at_date <= ? and user_id = ?", at_date.end_of_day, user_id]).first
  end

  def transactionUntilDate(at_date)
    Transaction.where(["at_date <= ?", at_date.end_of_day]).first
  end

  def transactionCurrentCebInvoiceAmountWithCurrency(at_date)
    number_to_currency(transactionCurrentCebInvoiceAmount(at_date), unit: "$", format:"%u %n", precision:2)
  end

  def transactionCurrentCebInvoiceAmount(at_date)
    transactionCurrentCebInvoice(at_date).amount
  end

  def transactionCurrentCebInvoice(at_date, user_id = 20)
    Transaction.where(["at_date between ? and ? and user_id = ?", at_date.beginning_of_month, at_date.end_of_month, user_id]).first
  end

  def transactionCebMonthYear(at_date)
    l(transactionCebDate(at_date), format:'%b-%Y')
  end

  def transactionCebDate(at_date)
    at_date.months_ago(2)
  end

  def transactionCurrentDateByUser(user_id)
    trx = transactionCurrent(user_id)
    trx ? trx.at_date : ""
  end

  def transactionCurrentAmountByUser(user_id)
    transactionCurrent(user_id).amount
  end

  def transactionPrevAmountByUser(user_id)
    transactionPrev(user_id).amount
  end

  def transactionCurrent(user_id = 22)
    Transaction.where(user_id:user_id).order("at_date desc").first
  end

  def transactionLastPayment(user_id, at_date)
    Transaction.where(:billed => false).where(["user_id = ? and at_date < ?", user_id, at_date.end_of_month]).order("at_date desc").first
  end

  def transactionPrev(user_id = 22)
    Transaction.where(user_id:user_id).order("at_date desc").second
  end

  def transactionUpdatedBilled(transaction, invoice_id, medition_id)
    transaction.invoice_id = invoice_id
    transaction.medition_id = medition_id
    transaction.billed = true
    transaction.save()
    puts "transaction.error #{transaction.errors.full_messages}"
  end

end

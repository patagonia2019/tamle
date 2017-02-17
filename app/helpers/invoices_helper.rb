module InvoicesHelper

  def invoicePreviousReadingDate()
    invoiceUnusedMeditionDates().first.at_date
  end

  def invoiceUnusedMeditionDates()
    meditionDates().where.not(at_date: invoiceMeditionDates()) 
  end

  def invoiceMeditionDates()
    Invoice.select(:at_date)
  end

  def invoiceDates()
    Invoice.select(:at_date).uniq.order("at_date desc")
  end

  def invoiceGenerateBills(invoice)
    invoice.billed_date = Date.new()
    emissionGenerateBillsByInvoice(invoice)
  end

  def invoiceUpdateBilled(invoice) 
    invoice.billed = true
    invoice.billed_date = Date.current()
    invoice.save()
    puts "invoice #{invoice.errors.full_messages}"
  end
end

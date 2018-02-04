module EmissionsHelper
  def emissionGenerateBillsByInvoice(invoice)

    begin
      at_date = invoice.at_date
      consume = consumeInfo()

      number_of_members = consume.number_of_members()
      exceedance_m3 = consumeUserExceedance()
      exceedance_m3_amount = consumeUserExceedanceAmount()
      transactionCeb = transactionCurrentCebInvoice(at_date, user_id = 20)
      ceb_date = transactionCeb.at_date
      ceb_amount = transactionCeb.amount
      ceb_amount_by_user = (ceb_amount / number_of_members).ceil(0)

      puts "search medition SIA by date = #{at_date} user_id = 22"
      meditionSIA = meditionByDate(at_date, 22)
      puts "found #{meditionSIA.id} "

      puts "update medition SIA"
      meditionUpdateBilled(meditionSIA)

      puts "search transaction SIA Current"
      transactionSIA = transactionCurrent()
      sia_amount = transactionSIA.amount
      sia_date = transactionSIA.at_date
      puts "update transaction SIA with invoice.id = #{invoice.id} and meditionSIA.id = #{meditionSIA.id}"
      transactionUpdatedBilled(transactionSIA, invoice.id, meditionSIA.id)
      puts "update transaction Ceb with invoice.id = #{invoice.id} and meditionSIA.id = #{meditionSIA.id}"
      transactionUpdatedBilled(transactionCeb, invoice.id, meditionSIA.id)

      meditionsByDateExcludingUser(at_date, 22).each {|medition|
        
        prev_medition = meditionPrev(medition.at_date, medition.user_id)
        last_payment_transaction = transactionLastPayment(medition.user_id, at_date)
        last_payment_amount = 0
        last_payment_date = nil
        if last_payment_transaction != nil
          last_payment_amount = last_payment_transaction.amount
          last_payment_date = last_payment_transaction.at_date
        end

        social_quote_amount = consume.social_quote_amount
        if medition.user_id == 9
          social_quote_amount = 0
        end

        water_consumed = medition.measure - prev_medition.measure
        puts "water_consumed= #{water_consumed} = #{medition.measure} - #{prev_medition.measure}" 
        exceedance_m3_by_user = 0
        exceedance_m3_amount_on_user = 0
        if water_consumed > exceedance_m3
          exceedance_m3_by_user = (water_consumed - exceedance_m3).ceil
          exceedance_m3_amount_on_user = (exceedance_m3_by_user * exceedance_m3_amount).ceil(0)
        end

        water_fix_consume_on_user_amount = (consume.water_fix_consume_amount / number_of_members).ceil(0)
        water_provision_on_user_amount = (consume.water_provision_amount  / number_of_members).ceil(0)

        puts "\n== Calculating payment  =="

        prev_emission = emissionByDate(prev_medition.at_date, prev_medition.id)
        prev_balance_amount = prev_emission != nil ? prev_emission.balance_amount : 0
        prev_emission_date = prev_emission != nil ? prev_emission.at_emission_date : prev_medition.at_date
        puts "prev_emission.balance_amount = #{prev_balance_amount}"
        puts "prev_emission_date = #{prev_emission_date}"
        puts "social_quote_amount = #{social_quote_amount}"
        puts "ceb_amount_by_user = #{ceb_amount_by_user}"
        puts "water_fix_consume_amount= #{water_fix_consume_on_user_amount}"
        puts "water_provision_amount= #{water_provision_on_user_amount}"
        puts "exceedance_m3_amount_on_user= #{exceedance_m3_amount_on_user}" 
        puts "last_payment_amount= #{last_payment_amount}" 
        puts "last_payment_date= #{last_payment_date}" 
        puts "at_date= #{at_date}" 
        balance_amount = prev_balance_amount
        balance_amount += social_quote_amount
        balance_amount += ceb_amount_by_user
        balance_amount += water_fix_consume_on_user_amount
        balance_amount += water_provision_on_user_amount
        balance_amount += exceedance_m3_amount_on_user 
        balance_amount -= last_payment_amount
        puts "balance_amount= #{balance_amount}" 

        begin
          emission = Emission.create :medition_id   => medition.id,
           :previous_medition_id                    => prev_medition.id,
           :at_emission_date                        => at_date,
           :consume_id                              => consume.id,
           :water_previous_measure                  => prev_medition.measure,
           :water_measure                           => medition.measure,
           :water_consumed                          => water_consumed,
           :exceedance_m3                           => exceedance_m3,
           :exceedance_m3_by_user                   => exceedance_m3_by_user,
           :exceedance_amount                       => exceedance_m3_amount,
           :exceedance_m3_amount_on_user            => exceedance_m3_amount_on_user,
           :water_fix_consume_amount                => consume.water_fix_consume_amount,
           :water_fix_consume_on_user_amount        => water_fix_consume_on_user_amount,
           :water_provision_amount                  => consume.water_provision_amount,
           :water_provision_on_user_amount          => water_provision_on_user_amount,
           :ceb_date                                => ceb_date,
           :ceb_amount                              => ceb_amount,
           :ceb_amount_by_user                      => ceb_amount_by_user,
           :sia_amount                              => sia_amount,
           :sia_date                                => sia_date,
           :social_quote_amount                     => social_quote_amount,
           :balance_previous_amount                 => prev_balance_amount,
           :balance_previous_date                   => prev_emission_date,
           :payment_amount                          => last_payment_amount,
           :payment_date                            => last_payment_date,
           :balance_amount                          => balance_amount,
           :invoice_id                              => invoice.id,
           :user_id                                 => medition.user_id
        
        rescue ActiveRecord::RecordInvalid => invalid
          puts "create #{invalid.class} and #{invalid.message}"
        end
        puts "emission.errors #{emission.errors.full_messages}"

        if last_payment_transaction != nil
          transactionUpdatedBilled(last_payment_transaction, invoice.id, medition.id)
        end

        puts "search medition by date = #{at_date} user_id = #{medition.user_id}"
        meditionToUpdate = meditionByDate(at_date, medition.user_id)
        puts "update billed medition #{meditionToUpdate.id}"
        meditionUpdateBilled(meditionToUpdate)

        invoiceUpdateBilled(invoice)
      }

      puts "DONE!"

    rescue Exception => error
      puts "end #{error.class} and #{error.message}"
      
    end

  end


  def emissionByDate(at_date, medition_id)
    Emission.where(["at_emission_date between ? and ? and medition_id = ?", at_date.months_since(-1).beginning_of_month, at_date, medition_id]).first
  end

  def emissionPrintLastGroup()
    at_date = Time.current.to_date
    at_emission_date = invoiceLast().at_date
    rows=""
    rows = rows + "<tr>"
        rows = rows + "<td colspan=2 class='td-right'></td>"
        rows = rows + "<td width=30%><u>Ultima Boleta (#{invoiceLast().at_date})</u> </td>"
        rows = rows + "<td width=30%><u>Ultimo Pago</u> </td>"
        rows = rows + "<td width=30%><u>Saldo</u> </td>"
    rows = rows + "</tr>"
    Emission.where(["at_emission_date = ?", at_emission_date]).order("balance_amount desc").each { |emission|
        rows = rows + "<tr>"
        rows = rows + "<td colspan=2 class='td-right'>#{User.find(Medition.find(emission.medition_id).user_id).name}</td>"
        last_payment_transaction = transactionLastPayment(emission.user_id, at_date)
        balance_amount = emission.balance_amount
        rows = rows + "<td width=30%><b>#{number_to_currency(balance_amount, unit: "$", format:"%u %n", precision:0)}</b> </td>"
	if last_payment_transaction != nil
        	balance_amount -= last_payment_transaction.amount
        	rows = rows + "<td width=30%><b>#{number_to_currency(last_payment_transaction.amount, unit: "$", format:"%u %n", precision:0)}</b> </td>"
	else
        	rows = rows + "<td width=30%><b>$ 0</b> </td>"
	end
	rows = rows + "<td width=30%><b>#{number_to_currency(balance_amount, unit: "$", format:"%u %n", precision:0)}</b> </td>"

#	rows = rows + "<td>#{Medition.find(emission.medition_id).user_id}</td>"
#	rows = rows + "<td>#{at_date}</td>"
        rows = rows + "</tr>"
    }
    rows.html_safe
  end

  def emissionPrintLastGroup2()
    at_date = invoiceLast().at_date
    rows="<tr>"
    count = 1
    Emission.where(["at_emission_date = ?", at_date]).order("balance_amount desc").each { |emission|
        if (count > 4)
            count = 0
        end
        @r = (count == 0)
        if @r == true
            rows = rows + (@r ? "</tr><tr>" : " ")
        end
        rows = rows + "<td>#{User.find(Medition.find(emission.medition_id).user_id).name}</td>"
        rows = rows + "<td class='td-right'><b>#{number_to_currency(emission.balance_amount, unit: "$", format:"%u %n", precision:0)}</b> </td><td>|</td>"
        count = count + 1
    }
    rows = rows + "</tr>"
    rows.html_safe
  end

  def emissionPrintLastGroupByDate(at_date)
    rows="<tr>"
    count = 1
    Emission.where(["at_emission_date = ?", at_date]).order("balance_amount desc").each { |emission|
        if (count > 4)
            count = 0
        end
        @r = (count == 0)
        if @r == true
            rows = rows + (@r ? "</tr><tr>" : " ")
        end
        rows = rows + "<td>#{User.find(Medition.find(emission.medition_id).user_id).name}</td>"
        rows = rows + "<td class='td-right'><b>#{number_to_currency(emission.balance_amount, unit: "$", format:"%u %n", precision:0)}</b> </td><td>|</td>"
        count = count + 1
    }
    rows = rows + "</tr>"
    rows.html_safe
  end
end

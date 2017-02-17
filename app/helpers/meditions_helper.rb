module MeditionsHelper
  def meditionTotalConsumption()
    meditionCurrentMeasure() - meditionPrevMeasure()
  end

  def meditionCurrentMeasure()
    meditionCurrent().measure
  end

  def meditionCurrentDate()
    meditionCurrent().at_date
  end

  def meditionLastEmission()
    meditionCurrentDate().strftime("%b-%Y")
  end

  def meditionPrevMeasure()
    meditionPrev().measure
  end
  def meditionPrevDate()
    meditionPrev().at_date
  end

  def meditionCurrent(user_id = 22)
    Medition.where(user_id:user_id).order("measure desc").first
  end

  def meditionByDate(date, user_id = 22)
    Medition.where(at_date: date, user_id:user_id).order("measure desc").first
  end

  def meditionsByDate(date)
    Medition.where(at_date: date).order("measure desc")
  end

  def meditionsByDateExcludingUser(date, user_id)
    Medition.where(:billed => false).where(["at_date = ? and user_id != ?", date, user_id])
  end

  def meditionPrev(at_date, user_id = 22)
    Medition.where(["at_date between ? and ? and user_id = ?", at_date.months_since(-1).beginning_of_month, at_date, user_id]).first
  end

  def meditionDates()
    Medition.where(:billed => false).select(:at_date).uniq.order("at_date desc")
  end

  def meditionUpdateBilled(meditionInstance) 
    meditionInstance.billed = true
    meditionInstance.save()
    puts "medition.error #{meditionInstance.errors.full_messages}"
  end
end

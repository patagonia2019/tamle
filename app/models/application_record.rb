class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  class DateOrBlankValidator < ActiveModel::EachValidator
    def validate_each(record,attribute,value)
      record.errors[attribute] << "must be a valid datetime or blank" unless value.blank? or ((DateTime.parse(value) rescue nil))
    end
  end
end

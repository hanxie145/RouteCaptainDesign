class EmailCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      error = "not an email address"
      record.errors[attribute] << (options[:message] || error)
    end
  end
end
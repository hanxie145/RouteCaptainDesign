class EmailExistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    err = ValidatesEmailFormatOf::validate_email_format(value, :check_mx => true)
    if !err.nil?
      error = "invalid email address"
      record.errors[attribute] << (options[:message] || error)
    end
  end
end
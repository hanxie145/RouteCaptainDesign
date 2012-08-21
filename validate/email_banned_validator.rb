class EmailBannedValidator < ActiveModel::EachValidator
  def validate_each(record, attributes, value)
    result = false
    if !value.nil? && value.index("@") != nil
      email_parts = value.split("@")
      banned = %w[aol.com aol.ca games.com love.com ygm.com wow.com]
      banned.each do |ban|
        if email_parts[1].downcase == ban
          result = true
          break
        end
      end
    end
    if result
      error = "disallowed email provider"
      record.errors.add(attributes, error, options)
    end
  end
end
class WebValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    url = URI.unescape(value).to_s
    url = "http://" + url
    result = false
    begin
      w = Whois::Client.new
      r = w.query(url)
      result = r.available?
    rescue Whois::ServerNotFound
      result = false
    end
    record.errors[attr_name] << "invalid website" if !result
    record.errors[attr_name].flatten!
  end
end
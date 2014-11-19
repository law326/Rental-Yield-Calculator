class WebApiUtil
  @@END_POINT = 'http://api.zoopla.co.uk'

  def self.get(path, params={})
    self.call(path, params, :get)
  end

  def self.post(path, params={})
    self.call(path, params, :post)
  end

  def self.post_ssl(url, ssl, params={})
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = ssl

    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(params)
    response = http.request(request)

    return response
  end

  private
  def self.call(path, params={}, method)
    start_time = Time.now
    uri = URI(WebApiUtil.get_web_api_end_point + "/" + path)
    Rails.logger.tagged(":::::", Time.now, "INF"){ Rails.logger.info("API request. URI: #{uri}, HTTP verb: #{method}, Params: #{params}") }

    begin
      if method == :get
        uri.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(uri)
      elsif method == :post
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(params)

        response = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(request)
        end
      end
      elapsed_time = ((Time.now - start_time)*1000).to_i

      Rails.logger.tagged(":::::", Time.now, "INF"){ Rails.logger.info("API response. URI: #{uri}, HTTP verb: #{method}, Params: #{params}, Result: #{response}, Response body: #{response.body}") }

      case response.code
      when "200"
        response.body
      when "404"
        message = "API called failed(404). URI: #{uri}, HTTP verb: #{method}, Params: #{params}"
        Rails.logger.tagged(":::::", Time.now, "ERR"){ Rails.logger.error(message) }
        raise "API called failed(404). #{message}"
      else
        response.error!
      end
    rescue Errno::ECONNREFUSED
      message = "API Connection was refused. URI: #{uri}, HTTP verb: #{method}, Params: #{params}"
      Rails.logger.tagged(":::::", Time.now, "ERR"){ Rails.logger.error(message) }
      raise "API Connection was refused. #{message}"
    rescue Exception => exception
      message = "API called failed(Other reason). URI: #{uri}, HTTP verb: #{method}, Params: #{params}, Exception: #{exception.message}"
      Rails.logger.tagged(":::::", Time.now, "ERR"){ Rails.logger.error(message) }
      raise "API called failed(Other reason). #{message}"
    end
  end

  def self.get_web_api_end_point
    return @@END_POINT
  end
end

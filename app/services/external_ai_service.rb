require "uri"
require "net/http"
require "json"

class ExternalAiService
  def get_response(message)
    url = URI(ENV["API_URI"]) 

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    params = {
      providers: ["openai"],
      text: message,
      temperature: 0.5,
      max_tokens: 50
    }

    request = Net::HTTP::Post.new(url)
    request["accept"] = "application/json"
    request["content-type"] = "application/json"
    request["authorization"] = "Bearer #{ENV['API_KEY']}"  
    request.body = params.to_json

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data["openai"]["generated_text"]
    else
      puts "Error: #{response.message}"
      nil
    end
  end
end

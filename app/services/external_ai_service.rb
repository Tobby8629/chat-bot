require "uri"
require "net/http"
require "json"

class ExternalAiService
  def get_response(message) # Accept question as a parameter
    url = URI("https://api.edenai.run/v2/text/chat")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    # Prepare the parameters, using the passed-in question
    params = {
      providers: [ "openai" ],
      text: message,
      temperature: 0.5,
      max_tokens: 50
    }

    request = Net::HTTP::Post.new(url)
    request["accept"] = "application/json"
    request["content-type"] = "application/json"
    request["authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNTMyMWZjNzUtMDI4Zi00YWNlLWI4MWQtMmNlMGRkNDhjNTA3IiwidHlwZSI6ImFwaV90b2tlbiJ9.9NPKv6XshrI-7--iB47uXWnrRV95dwl_wF3KxihuuYo"
    request.body = params.to_json

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data["openai"]["generated_text"]
    else
      puts "Error: #{response.message}" # Log the error
      nil # Return nil or handle the error appropriately
    end
  end
end

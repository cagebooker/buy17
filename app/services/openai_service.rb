require 'faraday'
require 'json'
class OpenaiService
  def self.generate_text(prompt)
    conn = Faraday.new(url: 'https://api.openai.com') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url '/v1/completions'
      req.body = { prompt: prompt, max_tokens: 200, temperature: 0 }.to_json
    end

    # render json: response
    response
  end
end
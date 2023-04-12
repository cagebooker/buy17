class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(message, model = 'text-davinci-003')
    # api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
      }
    }
    @api_url = 'https://api.openai.com/v1/completions'
    @model = model
    @message = message
  end

  def call
    body = {
      model:'text-davinci-003',
      # messages: [{ role: 'assistant', content: message }],
      prompt: message
      max_tokens: 600,
      temperature: 0
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 20)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['text']
  end

  class << self
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end
end
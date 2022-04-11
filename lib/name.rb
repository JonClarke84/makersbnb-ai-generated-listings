require 'dotenv/load'
require_relative 'openai'

class Name
  def generate
    @_generate ||= openai.completion(
      prompt: name_prompt,
      max_tokens: 16,
      temperature: 1.0
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def name_prompt
    "Give me a name and surname in no more than 60 characters."
  end
end
require 'dotenv/load'
require_relative 'openai'

class Location
  def generate(description:)
    @_generate ||= openai.completion(
      prompt: location_prompt(description: description),
      max_tokens: 16,
      temperature: 0.4
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def location_prompt(description:)
    "Give me a UK town or city that could match this description of a holiday rental." + description
  end
end
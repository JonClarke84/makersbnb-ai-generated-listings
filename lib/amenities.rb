require 'dotenv/load'
require_relative 'openai'

class Amenities
  def generate
    @_generate ||= openai.completion(
      prompt: amenities_prompt,
      max_tokens: 64,
      temperature: 1.0
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def amenities_prompt
    'Generate a list of ten holiday rental amenities, ranging from cool to mundane.'
  end
end

puts Amenities.new.generate

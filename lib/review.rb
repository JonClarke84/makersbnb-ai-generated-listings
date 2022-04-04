require 'dotenv/load'
require 'yaml'
require_relative 'openai'

class Review
  def generate
    @_generate ||= openai.completion(
      prompt: review_prompt,
      max_tokens: 64,
      temperature: 1.0
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def review_prompt
    'Write an example review for a holiday rental'
  end
end

puts Review.new.generate

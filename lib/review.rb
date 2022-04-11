require 'dotenv/load'
require_relative 'openai'
require_relative 'description'

class Review
  def generate(description:)
    @_generate ||= openai.completion(
      prompt: review_prompt(description: description),
      max_tokens: 256,
      temperature: 0.8
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def review_prompt(description:)
    "Based on '#{description}', Generate a guest review of a UK-based holiday rental."
  end
end

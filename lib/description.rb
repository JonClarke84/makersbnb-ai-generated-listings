require 'dotenv/load'
require_relative 'openai'

class Description
  def generate
    @_generate ||= openai.completion(
      prompt: description_prompt,
      max_tokens: 512,
      temperature: 0.8
    ).dig('choices').first.dig('text')
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def description_prompt
    'Generate a description of a UK-based holiday rental.'
  end
end

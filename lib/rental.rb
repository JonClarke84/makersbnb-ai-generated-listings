require 'dotenv/load'
require_relative 'openai'
require_relative 'description'
require_relative 'name'
require_relative 'location'

class Rental

  attr_reader :description, :host_name, :host_email, :location, :price, :title

  def initialize
    @description = generate_description
    @title = generate_title(description: @description)
    @host_name = generate_host
    @host_email = generate_host_email(host_name: @host_name)
    @location = generate_location
    @price = generate_price
  end

  def generate_description
    Description.new.generate.lstrip!
  end

  def generate_title(description:)
    @_generate ||= openai.completion(
      prompt: "Give me a title for a rental based on this
      description: '#{description}'",
      max_tokens: 64,
      temperature: 1.0
    ).dig('choices').first.dig('text').lstrip!
  end

  def generate_reviews(number_of_reviews:)
    # to be continued...
  end

  def generate_host
    Name.new.generate
  end

  def generate_host_email(host_name:)
    host_name.lstrip!.downcase.gsub(/ /, '.') + '@example.com'
  end

  def generate_location
    Location.new.generate(description: @description).lstrip!
  end

  def generate_price
   Random.new.rand(40..200)
  end

  private

  def openai
    OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end
end

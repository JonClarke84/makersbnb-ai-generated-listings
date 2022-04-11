require './lib/rental'
require './lib/database_connection'

rental = Rental.new

# puts "TITLE: " + rental.title
# puts "DESCRIPTION: " + rental.description
# puts "HOST: " + rental.host_name
# puts "HOST EMAIL: " + rental.host_email
# puts "LOCATION: " + rental.location
# puts "PRICE: £" + rental.price.to_s + " per night"

DatabaseConnection.setup('makersbnb')

count = 0

while count < 100 do
  rental = Rental.new
  DatabaseConnection.query(
    "INSERT INTO places (host_name, host_email, place_title, place_price, location, description)
    VALUES($1, $2, $3, $4, $5, $6)
    RETURNING id, host_name, host_email, place_title, place_price, location, description;",
    [
      rental.host_name,
      rental.host_email,
      rental.title,
      rental.price,
      rental.location,
      rental.description]
    )
  count += 1
end
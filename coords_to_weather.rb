require 'open-uri'
require 'json'
require 'net/https'
require 'uri'

# If you experience an error relating to SSL,
#   uncomment the following two lines:

# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your location."

puts "What is the latitude?"
the_latitude = gets.chomp

puts "What is the longitude?"
the_longitude = gets.chomp

coords = the_latitude.to_s + "," + the_longitude.to_s


###################

url_of_data_we_want = "https://api.forecast.io/forecast/d76bcf5c4ad28a8801b408c89f11cb35/"+coords

#this is not an elegant solution but I have other BOOTH courses
raw_data = open(url_of_data_we_want, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
#raw_data = open(url_of_data_we_want).read

parsed_data = JSON.parse(raw_data)
currently = parsed_data["currently"]
the_temperature = currently["temperature"]


#HOURLY +++++++++++++++++++++
hourly = parsed_data["hourly"]
hourly_data = hourly["data"]
hourly_data_next = hourly_data[0]
the_hour_outlook = hourly_data_next["summary"]

#Daily +++++++++++++++++++++
dayly = parsed_data["daily"]
dayly_data = dayly["data"]
dayly_next = dayly_data[0]
the_day_outlook = dayly_next["summary"]

########################

# Your code goes below. Use the same approach as you did in
#   address_to_coords.rb to read from a remote API and parse
#   the results.

# Ultimately, we want the following line to work when uncommented:

puts "The current temperature at #{the_latitude}, #{the_longitude} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"

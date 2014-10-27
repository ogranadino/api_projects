require 'open-uri'
require 'json'
require 'net/https'
require 'uri'



# If you experience an error relating to SSL,
#   uncomment the following two lines:

# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"

the_address = gets.chomp
url_safe_address = URI.encode(the_address)

##########################

url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_address
raw_data = open(url_of_data_we_want).read

parsed_data = JSON.parse(raw_data)
results = parsed_data["results"]
first = results[0]

geometry = first["geometry"]
location = geometry["location"]

# Let's store the latitude in a variable called 'the_latitude',
#   and the longitude in a variable called 'the_longitude'.

the_latitude = location["lat"]
the_longitude = location["lng"]

##########################

url_safe_address = the_latitude.to_s + "," + the_longitude.to_s


url_of_data_we_want = "https://api.forecast.io/forecast/d76bcf5c4ad28a8801b408c89f11cb35/"+url_safe_address

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




# Your code goes below.

# Ultimately, we want the following line to work when uncommented:

puts "The current temperature at #{the_address} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook} for the hour."
puts "The outlook for the next day is: #{the_day_outlook}"

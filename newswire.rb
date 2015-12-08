require 'htmlentities'
require 'net/http'
require 'json'
require './api.rb'

# Fetch data
uri = URI('http://api.nytimes.com/svc/news/v3/content/nyt/all/24.json?limit=20&api-key=' + @newswirekey)
json = Net::HTTP.get(uri)
data = JSON.parse(json)

# Output
if data["status"] == "OK" then
	puts ""
	puts data["copyright"]
	puts "==================================================================="
	puts ""
	
	# Do article
	data["results"].each do |article|
		puts "[Start]"
		puts "=== " + HTMLEntities.new.decode(article["title"]) + " ==="
		puts HTMLEntities.new.decode(article["abstract"])
		puts article["url"]
		puts "[End]"
		puts ""
	end
	
	puts "==================================================================="
	puts data["copyright"]
	puts ""
else
	puts "Fetch error!"
end

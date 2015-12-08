require 'htmlentities'
require 'net/http'
require 'json'
require './api.rb'

# Get section
puts 'Sections(home, world, national, politics, nyregion, business, opinion, technology, science, health, sports, arts, fashion, dining, travel, magazine, realestate)'
print 'Which section do you want? '
section = gets.chomp

# Fetch data
uri = URI('http://api.nytimes.com/svc/topstories/v1/' + section + '.json?api-key=' + @topstorieskey)
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

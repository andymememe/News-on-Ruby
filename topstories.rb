require 'htmlentities'
require 'net/http'
require 'json'
require './api.rb'

# Get section
puts 'Sections(arts, automobiles, books/review, business, fashion, food, health, home, insider, magazine, movies, nyregion, obituaries, opinion, politics, realestate, science, sports, sundayreview, technology, theater, t-magazine, travel, upshot, us, world)'
print 'Which section do you want? '
section = gets.chomp

# Fetch data
uri = URI('http://api.nytimes.com/svc/topstories/v2/' + section + '.json?api-key=' + @key)
json = Net::HTTP.get(uri)
data = JSON.parse(json)

# Output
if data['status'] == 'OK'
    puts ''
    puts data['copyright']
    puts '==================================================================='
    puts ''

    # Do article
    data['results'].each do |article|
        puts '[Start]'
        puts '=== ' + HTMLEntities.new.decode(article['title']) + ' ==='
        puts HTMLEntities.new.decode(article['abstract'])
        puts article['url']
        puts '[End]'
        puts ''
    end

    puts '==================================================================='
    puts data['copyright']
    puts ''
else
    puts 'Fetch error!'
end

require 'rspotify'
require 'csv'
require 'time'
require 'uri'
require 'airrecord'
require 'net/http'
#require 'active_support/all'


counter=0
matched=0

if ARGV[0]
  
  

  #puts "enter song id"
  client_id = "8c5dd7750fe74b169ba653b69f472435"
  client_secret = "385aec12c3e742c7a025af5726edd87c"
  RSpotify.authenticate(client_id, client_secret)
  
  
  Airrecord.api_key = "keyDUJxfHLTxyJiyx"
  Artists = Airrecord.table("keyDUJxfHLTxyJiyx", "appEwJjlF5jz7uDfC", "artists")
  
  match = Artists.all(filter: '{name} = "test"')
  
  puts match.inspect
  
  
  exit 
  
  # Pass in api key to client
  #@client = Airtable::Client.new("keyDUJxfHLTxyJiyx")
  #@table = @client.table("appEwJjlF5jz7uDfC", "artists")
  
  #puts @table.methods
  
  #roots 3l8zmgJQPC9u9quwWVdXyQ
  #meditation 3lXiya367ceZHWSNjkLvUj
  
  #playlist_link = RSpotify::Playlist.find(user_id, ARGV[0]) Roots, Meditation, 
  list_of_lists =[
    ["3l8zmgJQPC9u9quwWVdXyQ","Roots","Roots Collection"],
    ["3lXiya367ceZHWSNjkLvUj","Instrumental", "Meditation"]
  ]
  
  playlist = RSpotify::Playlist.find('aio', "3lXiya367ceZHWSNjkLvUj")
  
  playlist.tracks.each do |line|
    sleep(1)
    #@records = @table.records
    artist = line.artists[0].name
    puts "link #{line.external_urls["spotify"]} for main artist #{artist}: #{line.album.name}"
    
    #check for artist record
    #must sanitize name url string first
    a_name = URI.escape(artist)
    
    # formula = "OR({name}='test')"
    # puts "formula: #{formula}"
    #
    # @table.select(sort: ["Order", "asc"], formula: "OR({name}='test')")
    
    
    #@records = @table.select(sort: ["Order", "asc"], formula: "{name}='test'")
    #@records = @table.select(sort: ["Order", "asc"], formula: "OR({name}='test')")
    
    @records.each do |ar|
      if ar.name==artist
        puts "we found a match"
        exit
      end
    end
    #exit
  end
  
  
  

end

#THIS WORKS
#curl "https://api.airtable.com/v0/appEwJjlF5jz7uDfC/artists?maxRecords=3&view=Grid%20view&filterByFormula=OR({name}='Krister%20Axel')" -H "Authorization: Bearer keyDUJxfHLTxyJiyx"
#

# curl "https://api.airtable.com/v0/appEwJjlF5jz7uDfC/artists?maxRecords=3&view=Grid%20view&filterByFormula=OR({name}='Krister%20Axel')" -H "Authorization: Bearer keyDUJxfHLTxyJiyx"
# puts q_string
#
# track  = line[0]
# artist = line[1]
# album  = line[2]
# tstamp = line[3]
#
# t = Time.parse(tstamp).to_i
#
# puts "process #{t} - find artist: #{artist} track: #{track}"
#
# found = RSpotify::Artist.search(artist)
# if found && found.size>1
#   begin
#     #puts "we found MORE THAN 1 #{artist}"
#     found.each do |artist_compare|
#       artist_compare.albums.each do |al|
#         #puts "searching #{al.name}"
#         al.tracks.each do |tr|
#           if tr.name==track
#             puts tr.external_urls["spotify"]
#             puts "#{track} | #{artist} | #{album}"
#             matched+=1
#             counter+=1
#             next
#           end
#         end
#       end
#     end
#   rescue
#     puts "errors looking up albums for #{artist}"
#     counter+=1
#   end
# else
#   #single match
#   #puts "we found #{artist}"
#   begin
#     found[0].albums.each do |al|
#       #puts "searching #{al.name}"
#       al.tracks.each do |tr|
#         if tr.name==track
#           puts tr.external_urls["spotify"]
#           puts "#{track} | #{artist} | #{album}"
#           matched+=1
#           counter+=1
#           next
#         end
#       end
#     end
#   rescue
#     puts "errors looking up albums for #{artist}"
#     counter+=1
#   end
#
# end
#
# puts "#{matched} songs were matched out of #{counter}."
# puts "."



#OR({name}='test')
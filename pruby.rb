#!/usr/bin/env ruby

require 'json'
require 'cloudinary'

name_col = []

puts "screw you STARTING OVER"
puts "---------"
puts "---------"
puts "set up cloudinary"

Cloudinary.config do |config|
  config.cloud_name = 'ashland-io-llc'
  config.api_key = '952256524654316'
  config.api_secret = '8Jsmf0qENIHgZlCarKaSpd5H4jg'
  config.secure = true
  config.cdn_subdomain = true
end

puts "---------"
puts "---------"
document = File.read("convertjson-sample.json")

parsed = JSON.parse(document)

counter=0

#puts JSON.pretty_generate(parsed)

#rss:channel:item
#next
#attachment_url:link

parsed['rss']['channel']['item'].each do |child|
 
        
      # mini_counter=0
#       full_desc=""
#       if child["title"]
#         if child["encoded"].first["__cdata"][0..2]!="img"
#          puts
#          puts "."
#          puts "TITLE"
#          puts child["title"]
#          puts child["link"]
#          child["encoded"].each do |x|
#            if mini_counter==0
#              full_desc=x["__cdata"].to_s
#              puts full_desc
#
#              #find images
#              images = full_desc.gsub(/img src="(.*)\...."/)
#              images.each do |im|
#                s="#{im.to_s}"
#                puts "download #{s[7..99]}"
#              end
#
#            else
#              excerpt=x["__cdata"].to_s
#              puts "excerpt: #{excerpt}"
#            end
#            mini_counter+=1
#          end
#         end
#       end
  if child["post_type"]["__text"] == "post"
    #puts child["title"]
  elsif child["post_type"]["__text"] == "attachment"
    
    filename= child["link"].to_s.split("/").last
    #Cloudinary::Uploader.upload(child["link"], options = {})
    #Cloudinary::Uploader.upload(child["link"], :use_filename => true, :unique_filename => false, {"tags":"archive"}, function(result) { console.log(result) });
    
    #puts "filename: #{filename}"
    
    #https://res.cloudinary.com/ashland-io-llc/image/upload/v1556129842/sample.jpg
    
    if name_col.any?{|a| a == filename} then
      puts "filename #{filename} is duplicated"
    else
      name_col.push(filename)
    end
    
  else
    #puts child.inspect
    puts "SKIPPED"
  end
  
  
  counter+=1
end



#cloudinary.uploader.upload("sample.jpg", {"crop":"limit","tags":"samples","width":3000,"height":2000}, function(result) { console.log(result) });




# document.each do |t|
#   puts t.inspect
#   counter+=1
#   if counter>10 then exit end
# end

puts "parsed #{counter} records."
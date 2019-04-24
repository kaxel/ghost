#!/usr/bin/env ruby

require 'json'

puts "screw you STARTING OVER"
puts "---------"
puts "---------"
puts "---------"
puts "---------"
document = File.read("convertjson.json")

parsed = JSON.parse(document)

counter=0

#puts JSON.pretty_generate(parsed)

#rss:channel:item
#next
#attachment_url:link

parsed['rss']['channel']['item'].each do |child|
 
    
    counter+=1
    
    if counter>100
      if child["attachment_url"]
        puts "ATTACHMENT"
        puts "download #{child["attachment_url"]["__text"]}"
      elsif child["title"]
        puts "TITLE"
        puts child["title"]
        puts child["link"]
        mini_counter=0
        child["encoded"].each do |x|
          if mini_counter==0
            puts x["__cdata"].to_s
          else
            puts "excerpt: #{x["__cdata"].to_s}"
          end
          mini_counter+=1
        end
      end
      if counter>105
        exit
      end
    end
  
end

# document.each do |t|
#   puts t.inspect
#   counter+=1
#   if counter>10 then exit end
# end

puts "parsed"
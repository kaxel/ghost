#!/usr/bin/env ruby

require 'json'

name_col = []

puts "screw you STARTING OVER"
puts "---------"
puts "---------"

puts "---------"
puts "---------"
document = File.read("convertjson.json")
parsed = JSON.parse(document)
scrubbed_links = []

counter=0
ghost=0
errors=0
nonspot=0
audio_backup=0
video=0
errdocs=[]

parsed['rss']['channel']['item'].each do |child|
  
  title = child["title"]
 
  if child["post_type"]["__text"] == "post"
    #full_desc=child["encoded"]["__cdata"].to_s
    #puts child.inspect
    if (child["encoded"].to_s.include? "open.spotify.com" or child["encoded"].to_s.include? "soundsgood.co")
      begin
      
        # exceptions
        # East Coast Indie Rock. - The 5:55's New Single: Slow Down
        
        puts "."
        puts ".."
        
        puts title
        #find first -
        pos = title.index(" - ")
        if title.index(" - ") && !title.index(":")
          newtext = "#{title.split(' - ')[0]}: #{title.split(' - ')[1]}"
          #puts newtext
        elsif pos
          first_half = title[0,pos]
          newtext = title[(pos+3),9999]
          
          #remove listen to
          if newtext.include? "Listen to "
            newtext=newtext.gsub!("Listen to ", "")
          end
          
          #puts newtext
          #puts ""
        end
        ghost+=1
      rescue => e
        errdocs.push e
        errors+=1
      end
    elsif child["encoded"].to_s.include? "youtube.com"
        puts "video post: #{title}"
        video+=1
    elsif child["encoded"].to_s.include? "sqs-audio-embed"
      begin
        findlink=child["encoded"][0].gsub!("\"__cdata\"=>", "")
        puts "sqs-audio-embed: #{findlink}"
        link = child["encoded"].to_s.gsub(/"{1}\S{8,}mp3/)[1,999]
        puts "backup mp3 link for #{link}"
        audio_backup+=1
      rescue => e
        errdocs.push e
      end
    else
      
      
      #handle nonSpotify blog posts
      puts ""
      puts "nonSpotify: #{child.inspect}"
      nonspot+=1
    end
  else 
    puts "process attachment."
    puts child["link"]
  end
  
  counter+=1
  
  # if counter > 200
  #   exit
  # end
  
end




puts "parsed #{counter} records. #{errors} errors. #{nonspot} nonspot. #{ghost} ghosts written. #{video} videos. #{audio_backup} mp3s backed up."

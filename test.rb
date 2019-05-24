#!/usr/bin/env ruby

require 'json'
require 'cloudinary'

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


    filename="Shane-Leonard---Empire-Builder.mp3"
    puts "filename: #{filename}"
    
    #Cloudinary::Uploader.upload(child["link"], options = {})
    # y = Cloudinary::Uploader.upload(filename, {"tags":"mp3", "use_filename":"true"});
    # public_id = y["public_id"]
    # secure_url = y["secure_url"]
    
    
    #for audio
    
    
    
    y = Cloudinary::Uploader.upload(filename, {"tags":["mp3", "archive"], "resource_type":"video", "use_filename":"true"});
    public_id = y["public_id"]
    secure_url = y["secure_url"]
    
    puts "#{public_id} --> #{secure_url}"
    
    
    
    #https://res.cloudinary.com/ashland-io-llc/image/upload/v1556129842/sample.jpg
    
    
    
    
    
    
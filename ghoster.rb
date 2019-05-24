require 'json'
load 'ghostparse.rb'

t_stamp = Time.now.to_i

system("cp ghost-sample.json #{t_stamp}.json")

document = File.read("#{t_stamp}.json")
parsed = JSON.parse(document)

title = ARGV[0]
html = ARGV[1].to_s

#if title && html
  #update time stamps
  t_stamp = Time.now.to_i
  parsed["meta"]["exported_on"]=t_stamp
  
  parsed["data"]["posts"][0]["published_at"]=t_stamp
  parsed["data"]["posts"][0]["created_at"]=t_stamp
  parsed["data"]["posts"][0]["updated_at"]=t_stamp
  
  
  parsed["data"]["posts"][0]["title"]=title
  slug=Ghostparse::slugify(title)
  parsed["data"]["posts"][0]["slug"]="blog/2019/5/1/youthful-indie-rock-swmrs-too-much-coffee-vevo-live-performance"
  
  preconverted = parsed["data"]["posts"][0]["mobiledoc"]
  newhtml = ""
  parsed["data"]["posts"][0]["mobiledoc"]=preconverted.gsub("THIS IS MY HTML", newhtml)
  
  puts "saving"
  File.open("#{slug}.json","w") do |f|
    f.write(JSON.pretty_generate parsed)
  end
  puts "saved"
  system("rm #{t_stamp}.json")
  
#end
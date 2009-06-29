

# require this file to get all the frozen/unpacked gems into the load path
#
# ( created via frigo.rb  http://gist.github.com/87639 )

here = File.expand_path(File.dirname(__FILE__))

Dir.entries(here).select { |p|
  p.match(/^[^\.]/) and File.directory?("#{here}/#{p}/lib")
}.each { |p|
  $:.unshift("#{here}/#{p}/lib")
}


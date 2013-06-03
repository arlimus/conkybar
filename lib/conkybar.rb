module Conkybar
  VERSION = '0.0'
  INSTALL_PATH="~/.conkycolors"

  def set_net_device dev, network_file = 'cnetwork'
    f = File::expand_path(File::join(INSTALL_PATH,network_file))
    r = File::read(f).
      gsub(/(if_up|upspeedgraph|downspeedgraph|addr)\s+[a-z0-9]+/, "\\1 #{dev}").
      gsub(/(wireless_link_bar\s+[0-9]+,[0-9]+)\s+[a-z0-9]+/, "\\1 #{dev}")
    File::write f, r
    puts "done (set net to #{dev})"
  end

  def set_weather_code location, weather_file = 'cweather'
    f = File::expand_path(File::join(INSTALL_PATH,weather_file))
    r = File::read(f).
      gsub(/(weatherhelper\/weather.com.sh)\s+[A-Z0-9]+/,"\\1 #{location}")
    File::write f, r
    puts "done (set weather location to #{location})"
  end
end

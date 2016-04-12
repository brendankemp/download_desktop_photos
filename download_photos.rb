require 'rss'
require 'open-uri'

rss_url = ENV['PHOTO_RSS']
desktops_path = ENV['DESKTOPS_PATH']

rss = RSS::Parser.parse(rss_url, false)

photo_urls = rss.items.map(&:link)

photo_urls.each do |photo_url|
  photo_uri = URI.parse(photo_url)
  filename = File.basename(photo_uri.path)

  open(desktops_path + filename, 'wb') do |file|
    file << open(photo_url).read
  end
end

require 'pry'
require 'dotenv'
require 'yaml'
require 'uri'
require 'koala'
require 'yt'

Dotenv.load
fb_token   = ENV.fetch('FB_TOKEN')
yt_token   = ENV.fetch('YT_TOKEN')

cache_name = 'cache.yml'
hosts      = %w(youtu.be youtube.com www.youtube.com)
category   = 'Music'
fields     = %w(name link created_time)

# Try to get from cache
all_posts = YAML.load_file(cache_name) || []

# Use facebook graph api v2.5
Koala.config.api_version = 'v2.5'

# Graph explorer
graph = Koala::Facebook::API.new(fb_token)

# Set the youtube credentials
Yt.configuration.api_key    = yt_token
Yt.configuration.log_level  = :debug

if all_posts.empty?
  # Get the first batch
  posts = graph.get_connection('me', 'posts', fields: fields)
  all_posts += posts.to_a

  # Get all the other batches
  while posts
    posts = posts.next_page
    all_posts += Array(posts)
  end

  # Cleanup
  all_posts.select! do |post|
    # Must have a link
    post['link'] &&
    # Must be from youtube
    hosts.include?(URI.parse(post['link']).host)
  end

  all_posts.select! do |post|
    begin
      # Some videos no longer exist
      video = Yt::Video.new(url: post['link'])

      # We only care for music videos
      video && video.category_title == category
    rescue
      false
    end
  end

  File.write(cache_name, all_posts.to_yaml)
end

Pry.start

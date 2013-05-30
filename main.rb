require_relative 'data_fetching'
require 'twitter'


df = TweetFetcher.new

puts df.user_tweets 'jdmalandruccolo'

tweets = df.tweets_near 34.05,-118.25,10,5
# => TODO: consider writing a TweetAdapter class that provides a simple client for the tweets
tweets.each do |t|
	puts t.text
end
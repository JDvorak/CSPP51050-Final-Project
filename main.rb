require_relative 'data_fetcher'
require 'twitter'


df = DataFetcher.new

df.user_tweets "jdmalandruccolo"
tweets = df.tweets_near 0,0,0,0
# => TODO: consider writing a TweetAdapter class that provides a simple client for the tweets
puts tweets.first.text
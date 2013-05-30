require_relative 'secret'
require 'twitter'

class DataFetcher

	# => setup twitter
	def initialize

		Twitter.configure do |config|
  			config.consumer_key = $consumer_key
  			config.consumer_secret = $consumer_secret
  			config.oauth_token = $access_token
  			config.oauth_token_secret = $access_secret
		end
	end


	# => fetch the previous 20 tweets from a given user
	# => returns an array of Tweet objects
	def user_tweets screen_name

		tweets = Twitter.user_timeline("jdmalandruccolo")
		
		tweets

	end


	# => fetch an arbitrary number of tweets within a given radius of a lat and long
	# => specify the number of tweets with count
	# => returns an array of Tweet objects
	def tweets_near lat, long, radius, count
		# => TODO: implement actual parameters into search
		search_params = { geocode: "41.85,-87.65,10mi", count: 10, result_type: "recent" }
		search_result = Twitter.search("", search_params)

		tweets = search_result.statuses

	end

end
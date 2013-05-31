require_relative 'secret'
require 'twitter'
require 'fred'

# => class that interfaces with the twitter API
# => produces raw Tweet data
class TweetFetcher

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
		Twitter.user_timeline(screen_name.to_s)
	end


	# => fetch an arbitrary number of tweets within a given radius of a lat and long
	# => specify the number of tweets with count
	# => returns an array of Tweet objects
	def tweets_near lat, long, radius, count

		search_params = { geocode: "#{lat.to_s},#{long.to_s},#{radius.to_s}mi", count: count.to_i, result_type: "recent" }
		search_result = Twitter.search("", search_params)

		search_result.statuses

	end

end


# => class that interfaces with the Federal Reserve Bank of St. Louis FRED API
# => returns raw economic data
class FREDFetcher

	# => setup FRED
	def initialize
		@fred = Fred::Client.new( api_key: $fred_key )
	end

	# => return an array of possible categories
	# => passing '0' as the node returns the top level categories
	def list_children_for id
		raw_output = @fred.category( 'children', category_id: id.to_s )

		raw_output.categories.category
	end


	# => get the output of a category
	# => returns Hashie object with attributes that can be called as if
	# => 	they were object properties i.e. Hashie.name
	def get_category id
		raw_output = @fred.category( nil, category_id: id.to_s )

		raw_output.categories.category
	end


end
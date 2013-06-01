# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Model' layer
# => the primary responsibility of this class is to construct and manage
# => 	the individual units that make up this analysis
# => raw API is output is read from the 'Data Fetching' layer and assembled
# => 	into a format this is useful for later use in the application
# => this layer also manages data persistence and storage

require_relative 'secret'
require_relative 'data_fetching'
require 'aws-sdk'

# => class that represents a 'Tweet' from Twitter
# => suppresses unnecessary data contained in a 'Tweet' object returned
# => 	by the 'Data Fetching' layer
# => adds a hash table that supports dynamically adding an arbitrary number
# => 	of attributes of an arbitrary type at runtime
class TweetAdapter

	attr_reader :text, :state

	def initialize text, state
		@text = text
		@state = state
	end
	
end


# => class that represents the database of tweets
# => primary responsibility: serve as the shared interface with AWS SimpleDB
# => 	write tweets to the database and read them as requested
# => 	server as an adapter by abstracting useful queries into single methods
# => 	and preventing arbitrary queries from hitting the database
class SimpleDBManager

	def self.shared_instance
		@@shared_instance ||= new
	end

	private_class_method :new

	# => write a TweetAdapter object to Amazon SimpleDB
	def write_tweet tweet_adapter

		sdb = AWS::SimpleDB.new(access_key_id: $aws_access, secret_access_key: $aws_secret)

		domain = sdb.domains['cspp51050-final']
		tweet_id = domain.items.count + 1
		tweet = domain.items["#{tweet_id}"]
		tweet.attributes[:text].add tweet_adapter.text
		tweet.attributes[:state].add tweet_adapter.state

		return

	end


	# => get all tweets with a matching state attribute
	# => 	TweetAdapter objects are returned
	def tweets_for state

		sdb = AWS::SimpleDB.new(access_key_id: $aws_access, secret_access_key: $aws_secret)

		domain = sdb.domains['cspp51050-final']
		results = domain.items.where(state: state)

		convert_sdb_to_objects results
		
	end


	# => get all tweets in the database, limiting the results to n tweets
	def all_tweets_with_limit n
		
		sdb = AWS::SimpleDB.new(access_key_id: $aws_access, secret_access_key: $aws_secret)

		domain = sdb.domains['cspp51050-final']
		results = domain.items.limit(n)

		convert_sdb_to_objects results

	end


	# => given raw sdb objects, generate useful Ruby Objects
	def convert_sdb_to_objects sdb_output

		objects = []
		sdb_output.each do |r|
			attributes = r.attributes
			objects << TweetAdapter.new(attributes['text'].values.first, attributes['state'].values.first)
		end

		objects
		
	end


end



# => facade that encapsulates the functionality of the layer below in a simple
# => 	interface used by the model
class DataFetcherFacade

	TWEET_RADIUS = 20
	TWEETS_PER_GEO = 20

	def initialize
		@tweet_fetcher = TweetFetcher.new
		@fred_fetcher = FREDAdapter.new
		@shared_database = SimpleDBManager.shared_instance
		@location_arbiter = LocationArbiter.new
		@states = LocationArbiter::STATES
	end


	# => word get implies that we are going to the api to fetch tweets
	def get_tweets_in state

		geocodes = @location_arbiter.lat_long_for state
		raw_tweets = @tweet_fetcher.tweets_near geocodes[:latitude], geocodes[:longitude], TWEET_RADIUS, TWEETS_PER_GEO
		
		tweet_adapters_from raw_tweets, state

	end


	# => get the tweets and load them to SDB
	def get_and_write_tweets_in state

		tweet_adapters = self.get_tweets_in state

		tweet_adapters.each do |ta|
			@shared_database.write_tweet ta
		end
		
	end


	# => generate tweet adapters from tweets for a state
	def tweet_adapters_from tweets, state
		
		ta = []
		tweets.each do |t|
			ta << TweetAdapter.new(t.text, state)
		end

		ta

	end


	def load_tweets state

		@shared_database.tweets_for state
		
	end


end


# => class that manages the location data used in this project
class LocationArbiter
	require_relative 'city_locations'

	STATES = [
		'AL',
		'AK',
		'AZ',
		'AK',
		'CA',
		'CO',
		'CT',
		'DE',
		'FL',
		'GA',
		'HA',
		'ID',
		'IL',
		'IN',
		'IA',
		'KS',
		'KY',
		'LA',
		'ME',
		'MD',
		'MA',
		'MI',
		'MN',
		'MS',
		'MO',
		'MT',
		'NE',
		'NV',
		'NH',
		#'NJ',
		'NM',
		'NY',
		'NC',
		#'ND',
		'OH',
		'OK',
		'OR', 
		'PA',
		#'RI',
		'SC',
		'SD',
		'TN',
		'TX',
		'UT',
		#'VT',
		'VA',
		'WA',
		'WV',
		'WI',
		'WY'
	]

	def lat_long target_city
		
		# => linear search, use bsearch if ruby2.0
		$major_cities.each do |city|
			if city['city'].eql? target_city
				lat = city['latitude']
				long = city['longitude']

				return Hash[ latitude: lat, longitude: long ]
			end
		end

		raise "City data not available for #{target_city}"

	end


	def city_for state

		state_city_map = {

			'AL' => 'Birmingham',
			'AK' => 'Anchorage',
			'AZ' => 'Phoenix',
			'AR' => 'Jonesboro',
			'CA' => 'San Jose',
			'CO' => 'Denver',
			'CT' => 'New Haven',
			'DE' => 'Wilmington',
			'FL' => 'Pensacola',
			'GA' => 'Atlanta',
			'HA' => 'Honolulu',
			'ID' => 'Boise',
			'IL' => 'Chicago',
			'IN' => 'Indianapolis',
			'IA' => 'Sioux City',
			'KS' => 'Topeka',
			'KY' => 'Louisville',
			'LA' => 'New Orleans',
			'ME' => 'Auburn',
			'MD' => 'Baltimore',
			'MA' => 'Holyoke',
			'MI' => 'Detroit',
			'MN' => 'Mankato',
			'MS' => 'Jackson',
			'MO' => 'Kansas City',
			'MT' => 'Billings',
			'NE' => 'Omaha',
			'NV' => 'Las Vegas',
			'NH' => 'Manchester',
			#'NJ' => 'Newark',
			'NM' => 'Santa Fe',
			'NY' => 'New York',
			'NC' => 'Charlotte',
			#'ND' => 'Fargo',
			'OH' => 'Columbus',
			'OK' => 'Oklahoma City',
			'OR' => 'Eugene', 
			'PA' => 'Philadelphia',
			#'RI' => 'Providence',
			'SC' => 'Charleston',
			'SD' => 'Sioux Falls',
			'TN' => 'Memphis',
			'TX' => 'Houston',
			'UT' => 'Salt Lake City',
			#'VT' => 'Burlington',
			'VA' => 'Charlottesville',
			'WA' => 'Kennewick',
			'WV' => 'Huntington',
			'WI' => 'Milwaukee',
			'WY' => 'Riverton'

		}

		return state_city_map[state]

	end


	def lat_long_for state
		city = self.city_for state

		return self.lat_long city

	end

end
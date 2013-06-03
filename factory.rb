# => author: Joseph Malandruccolo
# => factory that controls object creation, from the perspective of the 
# => 	'Data Analysis' layer
require_relative 'data_model'


# => abstract factory class for factories that produce the objects required
# => 	in the analysis layer
class AbstractFactory

	def new
		raise "Cannot instantiate abstract class 'AbstractFactory'"
	end

	# => common initializer
	def initialize
		@data_facade = DataFetcherFacade.new
		@database_manager = SimpleDBManager.shared_instance
	end

end


# => factory that produces tweets for the analysis layer
class TweetFactory < AbstractFactory

	# => true if the state has tweets, false otherwise
	def has_tweets? state
		tweets = @database_manager.tweets_for state

		tweets.count > 0

	end


	# => get new tweets from the twitter api and write them to the database
	def build_tweets state
		@data_facade.get_and_write_tweets_in state
	end


	# => get 2500 tweets
	def all_tweets
		@database_manager.all_tweets_with_limit 2500
	end


	# => gets tweets in the database for a state
	def tweets_for state
		@database_manager.tweets_for state
	end

	# => get tweets for state from the database, if they exist
	# => 	if the tweets do not exist in the database, get them from twitter
	# => 	this operation will write the tweets to Amazon SimpleDB
	def force_tweets_for state
		tweets = self.tweets_for state
		tweets = self.build_tweets state unless tweets.count > 0

		tweets

	end

end


# => factory that produces state objects
class StateFactory < AbstractFactory


	# => produce a state object for the state indicated
	def object_for state
		un_rate = @data_facade.unemployment_rate state.upcase

		StateEconomy.new(state, un_rate)

	end

	# => returns an array of each state object
	def states
		states = LocationArbiter::STATES

		state_objects = []
		states.each do |s|
			state_objects.push(object_for s)
		end

		state_objects

	end

end
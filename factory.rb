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

	def has_tweets? state
		# => TODO: this method determines whether or not the database has tweets
		# => 	from all 50 states
	end


	def build_tweets state
		# => TODO: this method gets new tweets from the Twitter API, adds them
		# => 	to the database and returns the tweets
	end


	def all_tweets
		@database_manager.all_tweets_with_limit 2500
	end


	def tweets_for state
		@database_manager.tweets_for state
	end

end


# => factory that produces state objects
class StateFactory < AbstractFactory

	def object_for state
		un_rate = @data_facade.unemployment_rate state.upcase

		StateEconomy.new(state, un_rate)

	end

end
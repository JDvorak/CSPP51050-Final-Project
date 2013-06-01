# => author: Joseph Malandruccolo
# => factory that controls object creation, from the perspective of the 
# => 	'Data Analysis' layer
require_relative 'data_model'

class TweetFactory

	def initialize
		@data_facade = DataFetcherFacade.new
	end

	def fill_the_factory
		# => TODO: this method adds an arbitrary number of tweets
		# => 	from each state to the database
	end


	def is_full?
		# => TODO: this method determines whether or not the database has tweets
		# => 	from all 50 states
	end


	def read_database
		# => TODO: this method brings all tweet data into memory for analysis
	end

end
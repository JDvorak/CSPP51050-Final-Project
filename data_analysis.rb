# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Analysis' layer
# => the primary responsibility of these classes is to
# => 	analyze the composition of tweets and their relation
# => 	to macroeconomic variables
# => this layer employes a strategy pattern to analyze tweets
require_relative 'factory'


# => abstract class
class AbstractStrategy

	def new
		raise "Cannot instantiate abstract class 'AbstractStrategy'"
	end

	def initialize
		@tweet_factory = TweetFactory.new
		@state_factory = StateFactory.new
	end

end
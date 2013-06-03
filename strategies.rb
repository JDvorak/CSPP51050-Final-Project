# => author: Joseph Malandruccolo
# => strategies that analyze tweets, used in the
# => 	'Data Analysis' layer
require_relative 'data_model'


class AbstractTweetStrategy

	attr_reader :results_key

	def new
		raise "Cannot instantiate abstract class 'AbstractTweetStrategy'"
	end

	def initialize results_key
		@results_key = results_key
	end

	# => method should return the average of some attribute for each tweet
	# => call is added to the state as follows:
	# => 	create the state
	# => 	create the tweets for the state
	# => 	apply the strategy to the tweets, in a state
	# => 	strategy attaches the result of the strategy to the state
	def analyze tweets, state
		raise "Cannot call abstract method 'analyze_tone'"
	end

end


class ExplitiveAverager < AbstractTweetStrategy


	def analyze tweets, state

=begin
		average_explitives = #do something that counts explitives

		state.add_result @results_key, average_explitives
=end

		state.results[@results_key] = 69
		puts "counting explitives"

	end


end

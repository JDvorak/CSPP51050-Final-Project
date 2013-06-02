# => author: Joseph Malandruccolo
# => strategies that analyze tweets, used in the
# => 	'Data Analysis' layer
require_relative 'data_model'


class AbstractTweetStrategy

	def new
		raise "Cannot instantiate abstract class 'AbstractTweetStrategy'"
	end

	def initialize results_key
		@results_key = results_key
	end

	def analyze tweets
		raise "Cannot call abstract method 'analyze_tone'"
	end

end


class ExplitiveCounter < AbstractTweetStrategy


	def analyze tweets
		
	end


end

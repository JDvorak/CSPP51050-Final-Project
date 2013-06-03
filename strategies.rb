# => author: Joseph Malandruccolo
# => strategies that analyze tweets, used in the
# => 	'Data Analysis' layer
require_relative 'data_model'
require 'csv'


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


# => tweet analysis strategy that takes an array of tweets and averages
# => 	the number of explitives in the sample
# => the result is recorded in the state passed in the analyze method
class ExplitiveAverager < AbstractTweetStrategy


	# => average the number of explitives
	# => add that number as a rider to the state
	def analyze tweets, state

		average_explitives = avg_explitives tweets

		state.add_result @results_key, average_explitives

	end


	# => average the number of explitives in a given number of tweets
	# => read explitives from a csv and compare each word in the tweet to the
	# => 	explitive
	def avg_explitives tweets

		target_words = []
		CSV.foreach("resources/swearWords.csv") do |row|
			target_words = row
		end

		tweet_count = 0
		explitive_count = 0

		tweets.each do |tweet|

			tweet_count = tweet_count + 1
			# => REGEX no word characters, combining delimiters
			words = tweet.text.split(/\W+/)
			# => compare each word to our list
			words.each do |word|
				explitive_count = explitive_count + 1 if target_words.include? word.downcase
			end
		end

		result = explitive_count.to_f / tweet_count.to_f

		result.round(5)
		
	end


	private :avg_explitives


end

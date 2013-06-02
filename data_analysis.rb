# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Analysis' layer
# => the primary responsibility of these classes is to
# => 	analyze the composition of tweets and their relation
# => 	to macroeconomic variables
# => this layer employes a strategy pattern to analyze tweets
require_relative 'factory'


tweet_factory = TweetFactory.new
state_factory = StateFactory.new

tweets = tweet_factory.all_tweets
illinois = state_factory.object_for 'IL'

puts "#{illinois.unemployment_rate} - #{illinois.state}"

tweets.each do |t|
	puts "#{t.text} || #{t.state}"
end


# => abstract class representing an Analysis filter
# => 
class AnalysisFilter

	def new
		raise "Cannot instantiate Abstract class 'AnalysisFilter'"
	end

end


# => determines the 'tone of a tweet'
class ToneFilter < AnalysisFilter


end



# => determines the use of explitives
class ExplitiveFilter < AnalysisFilter

end
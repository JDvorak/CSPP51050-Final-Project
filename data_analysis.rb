# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Analysis' layer
# => the primary responsibility of these classes is to
# => 	analyze the composition of tweets and their relation
# => 	to macroeconomic variables
# => this layer employes a strategy pattern to analyze tweets
require_relative 'factory'
require_relative 'strategies'


# => class that coordinates the running of an analysis
# => single responsibility is to analyze a set of tweets and produce a result
class AnalysisCoordinator

	def initialize
		@tweet_factory = TweetFactory.new
		@state_factory = StateFactory.new
	end


	def analyze_tweets_with strategy
		
		# => 	create the states
		# => 	create the tweets for the state
		# => 	apply the strategy to the tweets, in a state
		# => 	strategy attaches the result of the strategy to the state
		# => fake this with dummy data, don't actually analyze tweets, just return 5
		states = @state_factory.states

		# => the code below is untested and mission critical
		# => PLEASE REVIEW AND TEST
		states.each do |state|
			#tweets = @tweet_factory.force_tweets_for state
			puts state.state
			puts state.unemployment_rate
			#strategy(tweets, state)

		end

		states 	# => the objects should now have a tag from the strategy

		# => here is where we present the results of the strategy
		

		# => single state strategy
		

	end


end


# => class that reads an input from the user interface and triggers
# => 	an analysis with the appropriate strategy
class AnalysisFacade

	def initialize
		@coordinator = AnalysisCoordinator.new
	end


	def analysis_for number

		case number
		when 1
			result = @coordinator.analyze_tweets_with ExplitiveAverager.new("explitive_count")
		when 2
			result = @coordinator.analyze_tweets_with ToneEvaluator.new("tone")
		else
			raise "Invalid selection in AnalysisFacade"	
		end

		puts result

	end


end
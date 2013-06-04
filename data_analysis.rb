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
=begin
		# => 	create the states
		# => 	create the tweets for the state
		# => 	apply the strategy to the tweets, in a state
		# => 	strategy attaches the result of the strategy to the state
		# => fake this with dummy data, don't actually analyze tweets, just return 5
		states = @state_factory.states

		# => the code below is untested and mission critical
		# => PLEASE REVIEW AND TEST
		states.each do |state|
			tweets = @tweet_factory.force_tweets_for state.state
			strategy.analyze(tweets, state)

		end

		states 	# => the objects should now have a tag from the strategy

		visualize(states)
		# => here is where we present the results of the strategy
=end

		# => single state strategy
		wyoming = @state_factory.object_for 'OK'
		tweets = @tweet_factory.force_tweets_for wyoming.state


		strategy.analyze(tweets, wyoming)

		wyoming.results[strategy.results_key]


		states = []
		states.push wyoming

		#visualize states

		states

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
			strategy = ExplitiveAverager.new("explitive_count")
			result = @coordinator.analyze_tweets_with strategy
		when 2
			strategy = ToneEvaluatorOne.new("tone")
			result = @coordinator.analyze_tweets_with strategy
		else
			raise "Invalid selection in AnalysisFacade"	
		end

		result.each do |r|
			puts "#{r.state} - #{r.unemployment_rate} | #{r.results[strategy.results_key]}"
		end

	end


end
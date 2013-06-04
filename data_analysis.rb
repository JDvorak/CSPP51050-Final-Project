# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Analysis' layer
# => the primary responsibility of these classes is to
# => 	analyze the composition of tweets and their relation
# => 	to macroeconomic variables
# => this layer employes a strategy pattern to analyze tweets
require_relative 'factory'
require_relative 'strategies'
require 'gchart'


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
=begin
		states = []
		states.push @state_factory.object_for 'OR'
		states.push @state_factory.object_for 'TN'
		states.push @state_factory.object_for 'IL'
=end
		
		states.each do |state|
			tweets = @tweet_factory.force_tweets_for state.state
			strategy.analyze(tweets, state)
		end

		states 	# => the objects should now have a tag from the strategy

		visualize states, strategy.results_key
		# => here is where we present the results of the strategy

		states

=begin
		# => single state strategy
		wyoming = @state_factory.object_for 'OK'
		tweets = @tweet_factory.force_tweets_for wyoming.state


		strategy.analyze(tweets, wyoming)

		wyoming.results[strategy.results_key]


		states = []
		states.push wyoming

		visualize states, strategy.results_key

		states
=end
	end


	def visualize states, results_key


		#order_states_by_unemployment states

		x_axis_labels = []
		y_axis_data = []
		y_axis_labels = [results_key]

		states.each do |state|
			x_axis_labels << "#{state.state}"
			y_axis_data << state.results[results_key]
		end	


		Gchart.bar(
			title: "#{results_key} vs. Unemployment Rate by State",
			data: y_axis_data,
			axis_with_labels: ['x', 'y'], 
			axis_labels: [x_axis_labels], 
			axis_range:[nil, [y_axis_data.min, y_axis_data.max, (y_axis_data.min + y_axis_data.max / 10)]],
			stacked: false,
			size: '800x200',
			format: 'file',
			filename: "results/result_#{Time.now.to_i}.png"
		)
		
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
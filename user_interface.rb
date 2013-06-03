# => author: Joseph Malandruccolo
# => class that represents a user interface for the analysis

require_relative 'data_analysis'

class UserInterface

	WHITELIST = [1,2]	# => list of possible user inputs

	def start

		puts "Welcome to the Twitter-Federal Reserve Bank of St. Louis Analysis Engine"
		sleep 2


		while true
			
			# => prompt user for input
			puts "Please select an analysis to run below:"
			puts "1 - Average number of explitives per tweet by state"
			puts "2 - Average tone (1 = positive - 10 = negative) of tweet by state"

			# => read user input
			user_input = gets.chomp
			puts "You selected: #{user_input}"
			break if WHITELIST.include? user_input.to_i
			puts "#{user_input} is invalid, please try again\n\n"

		end

		# => run the analysis
		puts "Please wait, magic is happening..."

		analysis_layer = AnalysisFacade.new
		result = analysis_layer.analysis_for user_input.to_i

		# => report the result
		puts "Results:"
		puts result

	end

end
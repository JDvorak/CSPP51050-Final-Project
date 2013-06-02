# => author: Joseph Malandruccolo
# => class that represents a user interface for the analysis

require_relative 'data_analysis'

class UserInterface

	WHITELIST = [1,2]

	def start

		puts "Welcome to the Twitter-Federal Reserve Bank of St. Louis Analysis Engine"
		sleep 2


		while true
			
			puts "Please select an analysis to run below:"
			puts "1 - Average number of explitives per tweet by state"
			puts "2 - Average tone (1 = positive - 10 = negative) of tweet by state"
			user_input = gets.chomp
			puts "You selected: #{user_input}"
			break if WHITELIST.include? user_input.to_i
			puts "#{user_input} is invalid, please try again\n\n"

		end

		puts "Please wait, magic is happening..."

		analysis_layer = AnalysisFacade.new
		# => line below not tested
		#result = analysis_layer.analysis_for user_input.to_i

		puts "Results:"
		#puts result

	end

end
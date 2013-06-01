# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Model' layer
# => the primary responsibility of this class is to construct and manage
# => 	the individual units that make up this analysis
# => raw API is output is read from the 'Data Fetching' layer and assembled
# => 	into a format this is useful for later use in the application
# => this layer also manages data persistence and storage

require_relative 'secret'
require 'aws-sdk'

# => class that represents a 'Tweet' from Twitter
# => suppresses unnecessary data contained in a 'Tweet' object returned
# => 	by the 'Data Fetching' layer
# => adds a hash table that supports dynamically adding an arbitrary number
# => 	of attributes of an arbitrary type at runtime
class TweetAdapter

	attr_reader :text, :state

	def initialize tweet, state
		@text = tweet.text
		@state = state
	end
	
end


# => class that represents the database of tweets
class SimpleDBManager

	def self.shared_instance
		@@shared_instance ||= new
	end

	private_class_method :new


	def write_tweet tweet_adapter

		sdb = AWS::SimpleDB.new(access_key_id: $aws_access, secret_access_key: $aws_secret)

		domain = sdb.domains['cspp51050-final']
		tweet_id = domain.items.count + 1
		tweet = domain.items["#{tweet_id}"]
		tweet.attributes[:text].add tweet_adapter.text
		tweet.attributes[:state].add tweet_adapter.state

		return

	end


end
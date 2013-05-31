require_relative 'data_fetching'
require_relative 'data_model'


#ta = TweetAdapter.new "this is a cool tweet", "Chicago"

tf = TweetFetcher.new

tweets = tf.tweets_near 25.78, -80.38, 10, 10
tweet_objects = []
tweets.each do |t|
	tweet_objects << TweetAdapter.new(t, "FL")
end

tweet_objects.each do |t|
	puts t.text
	puts t.state
end
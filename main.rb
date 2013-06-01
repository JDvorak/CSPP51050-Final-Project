require_relative 'data_fetching'
require_relative 'data_model'


#ta = TweetAdapter.new "this is a cool tweet", "Chicago"

tf = TweetFetcher.new
mgr = SimpleDBManager.shared_instance

tweets = tf.tweets_near 25.78, -80.38, 10, 10
tweet_objects = []
tweets.each do |t|
	tweet_objects << TweetAdapter.new(t, "FL")
end

mgr.write_tweet tweet_objects.first
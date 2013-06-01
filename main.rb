require_relative 'data_fetching'
require_relative 'data_model'



df = DataFetcherFacade.new

tweets = df.load_tweets 'TX'

tweets.each do |t|
	puts t.text
end
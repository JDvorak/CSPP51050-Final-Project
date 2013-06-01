require_relative 'data_fetching'
require_relative 'data_model'



df = DataFetcherFacade.new

tweets = df.get_and_write_tweets_in 'OK'
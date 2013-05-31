require_relative 'data_fetching'



fr = FREDFetcher.new


puts fr.search_series "unemployment", "full_text"
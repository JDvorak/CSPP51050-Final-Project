require_relative 'data_fetching'



fr = FREDFetcher.new


results = fr.get_data 'NDUR'
puts results
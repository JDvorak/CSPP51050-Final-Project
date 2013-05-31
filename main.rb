require_relative 'data_fetching'



fr = FREDFetcher.new


stuff = fr.get_category 32447

puts stuff
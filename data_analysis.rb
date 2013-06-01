# => author: Joseph Malandruccolo
# => classes that comprise the 'Data Analysis' layer
# => the primary responsibility of these classes is to
# => 	analyze the composition of tweets and their relation
# => 	to macroeconomic variables
# => this layer employes a strategy pattern to analyze tweets
require_relative 'data_model/ModelFactory'


# => fill the factory unless factory is full
# => load the factory or enough of the factory into memory 
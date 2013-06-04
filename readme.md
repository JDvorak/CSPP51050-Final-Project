Twitter Data Analysis
===========

Final project for CSPP 51050 - Object Oriented Architecture & Design  
This project seeks to map Tweet data from the Twitter API with economic data from the Federal Reserve Bank of St. Louis' FRED API.  
Results of the data analysis are visualized both as output on the command line and as a PNG file created using Google Charts 'https://developers.google.com/chart/'


Project Requirements
===========
1. One architectural pattern
2. Three design patterns


Project Specifications
===========
This project leverages the 'layers' architectural pattern with the following layers:  
+ User Interface
+ Data Analysis
+ Data Model
+ Data Fetching


This project leverages the following design patterns:  
+ Singleton => shared access to Amazon SimpleDB
+ Strategy => allow for flexible and dynamic algorithm selection in the Analysis layer at runtime
+ Facade => provide a simple interface for the calling API methods without the need to know about various other objects that manage the details of call paramters
+ Factory => allow the analysis layer to generate needed objects with a simple API, with the details of how and/or where the objects are created suppressed
+ Adapter => hide unused interface from the Twitter API's 'Tweet' object
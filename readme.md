Twitter Data Analysis
===========

Final project for CSPP 51050 - Object Oriented Architecture & Design  
This project seeks to map Tweet data from the Twitter API with either economic data from the Federal Reserve Bank of St. Louis' FRED API or an associative map to members of the United States Congress.  


Project Requirements
===========
1. One architectural pattern
2. Three design patterns


Project Specifications
===========
This project leverages the 'layers' architectural pattern with the following layers:  
+ User Interface
+ Control
+ Analysis
+ Data Model
+ Data Fetching


This project leverages the following design patterns:  
+ Singleton => shared access to economic data instances
+ Strategy => allow for flexible and dynamic algorithm selection in the Analysis layer
+ Pipes and Filters => allow flexible and dynamic analysis sequencing in the Analysis layer
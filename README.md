Border Delays
=============
Border Delays is an app that scrapes sites listed below once an hour in order to generate graphs displaying the average wait times for different borders at different times. It can be seen [here](http://border-times.herokuapp.com/)

1. [Canada Border Services Agency](http://www.cbsa-asfc.gc.ca/bwt-taf/menu-eng.html) 

2. [U.S. Customs and Border Protection](http://apps.cbp.gov/bwt/index.asp) 


###### Scrapers

Scrapers are found in `lib/tasks/scrape.rake` and can be run with  `rake scrape:times` . Data on the production server has been collected since November 11, 2013. Data was not collected from November 29, 2013 to April 14, 2014. 


###### Charts

charts were made using [chartJS](http://www.chartjs.org/)

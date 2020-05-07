# Repository for data on metropolitan dollar store expansion

This repo has data used for the article "Dollar stores, retailer redlining, and the metropolitan geographies of precarious consumption," published in the *Annals of the American Association of Geographers*. The author's version of this manuscript is located [on his professional website](http://jerry.shannons.us/publications.html).

There are three main scripts in the scripts folder of this repo:

* The mixedmetro_r script contains code for the Mixed Metro classification of census tracts using census obtained through [NHGIS](http://nhgis.org) 
* The cs_firstdifference_models script contains code for the cross sectional and first difference models.
* The ladderplot script creates the descriptive ladder plots shown in the article.

The data folder contains files that support these scripts. The most notable files are:

* dollars_all-A csv file showing all SNAP-authorized dollar store locations used in this analysis
* ustracts_mm_acs_10_17-A csv file with Mixed Metro classification for each tract from the 2008-2012 through 2013-2017 ACS.

The data used in the model is too large for Github and can be downloaded directly [using this link](https://www.dropbox.com/s/f791cgfj6wrcth6/modeldata.csv?dl=0).

These data came from a larger project on SNAP retailers, and more information on these files can be found on [the repo hosting those data](https://github.com/jshannon75/snap_retailers).
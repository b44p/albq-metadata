# albq-metadata
Digitizing Albuquerque Metadata
Albuquerque has a simple open data site that contains data listings that cover almost all services. Each of these datasets also has very good, detailed and structured metadata. However these metadata are stored in PDFs and it would be nice to have them as CSVs so that data can be made more searchable. 

This is an attempt to use a program called [pdfgrep](https://pdfgrep.org) to extract common elements from each of these PDF metadata documents and provide a csv of all of Albequerque's metadata. In order to run the extract, you will need to download and install pdfgrep. 
For MAC OSX, its as simple as doing **brew install pdfgrep**.

The script does the following:

* Parses the [ABQ-DATA](https://www.cabq.gov/abq-data/) webpage to get a list of all the metadata pdf files.
* Download's each metadata file
* For each metadata file, extract these elements from the PDF file. Each metadata file has some unique fields but I found these elements to be consistent across all files:
  * Dataset Title
  * Department/Division producing the data
  * Short Description
  * Start Date of the dataset
  * End Date of the dataset
  * Dataset Refresh Interval
  * Dataset Expiration Date
  * Dataset Review Date

To run:
* git clone this repo
* `./extract.sh`

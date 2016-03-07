#!/bin/bash
#City of Albuquerque Metadata extract
#Author: Varun Adibhatla - argolabs.org
#flush the results
>result.csv
# Remove all existing PDFs
#rm *.pdf
#This command extracts all the files containing metadata from https://www.cabq.gov/abq-data/ and adds it to a files.txt
curl -s https://www.cabq.gov/abq-data/ | grep MetaData.pdf | awk -F\" '{print $2}' | grep MetaData.pdf | sed 's/\/view//g' >files.txt
#Creating a header
echo "Title|Name|Department|Description|Start Date|End Date|Refresh Interval|Expiration Date|Review Date" >>result.csv
count=1
#For each metadata file
for i in $(cat files.txt)
do
	domain=`echo $i | awk -F"/" '{print $5}'`
	echo "Downloading the Metadata for $domain"
	wget -q $i -O $domain.pdf
	name=`pdfgrep Name $domain.pdf | head -1| awk -FName '{print $2}' | sed -e 's/^[ \t]*//'`
	title=`pdfgrep "Dataset Title" $domain.pdf | head -1 | awk -F"                               " '{print $2}'`
	dept=`pdfgrep "Department/Division" $domain.pdf | head -1| awk -F"Department/Division" '{print $2}' | sed -e 's/^[ \t]*//'`
	desc=`pdfgrep "Short Description" $domain.pdf | head -1| awk -F"Short Description" '{print $2}' | sed -e 's/^[ \t]*//'`
	start_date=`pdfgrep "Start Date" $domain.pdf | tail -1 | awk -F"Start Date" '{print $2}' | sed -e 's/^[ \t]*//'`
	end_date=`pdfgrep "End Date" $domain.pdf | tail -1 | awk -F"End Date" '{print $2}' | sed -e 's/^[ \t]*//'`
	refresh=`pdfgrep "Dataset Refresh Interval" $domain.pdf`
	expiration=`pdfgrep "Dataset Expiration Date" $domain.pdf`
	review_dt=`pdfgrep "Dataset Review Date" $domain.pdf`
	Id="ABQ"$count
	count=$((count+1))
	echo $Id"|"$i"|"$title"|"$name"|"$dept"|"$desc"|"$start_date"|"$end_date"|"$refresh"|"$expiration"|"$review_dt >>result.csv
done

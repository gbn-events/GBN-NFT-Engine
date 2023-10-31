#!/bin/bash

echo "******"
echo "Cleaning current json files..."
echo "******"
rm ./car/json.car
rm ./json/*
rm ./json/test/*
echo ""

# Prompt the user with a question
read -p "Have you updated all the URIs in the NFT-Plan '_lookup' sheet? Did you use the NFT-Plan macro to generate the '*ExportJson.csv' file? (yes/no) " yn

# Check the user's answer
case $yn in
    [Yy]*)
	# Run the command if the user answers yes
	echo "******"
	echo "Looking for new *ExportJson.csv file..."
	echo "******"
	mv -f ./*ExportJson.csv ./export-json.csv
	echo ""

	echo "******"
	echo "Running csv-to-json.py script..."
	echo "******"
	python3 csv-to-json.py --input ./export-json.csv --output_directory ./json --output_file_extension ""
	python3 csv-to-json.py --input ./export-json.csv --output_directory ./json --output_file_extension ".json"

	echo "******"
	echo "This is how many files the ./json/*.json directory has in it: $(ls -l ./json/*.json | wc -l)"
	echo "******"
	echo ""

	echo "******"
	echo "Building json car file..."
	echo "******"
	echo ""
	ipfs-car pack ./json --output ./cars/json.car
	echo ""
	echo "*** Note: You must copy the ipfs URI above and paste it in the Google Sheet (NFT-Plan _lookup 'CID json' for completeness! Don't forget!"
        ;;
    [Nn]*)
        # Do nothing if the user answers no
	echo ""
        echo "You must update the URIs, run the macro, save the csv file to the parent directory before generating the json car files! Come back soon..."
        ;;
    *)
        # Exit the script if the user enters an invalid response
	echo "Invalid response."
        exit 1
        ;;
esac
echo ""
echo "-------------------------------------------"
echo "Done with html..."
echo "-------------------------------------------"
echo ""


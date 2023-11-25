#!/bin/bash

echo "******"
echo "Cleaning current html files..."
echo "******"
rm ./car/html.car
rm ./html/*.html
rm ./html/test/*.html
echo ""

echo "******"
echo "Looking for new template and ExportHtml.csv files..."
echo "******"
mv -f ./*ExportHtml.csv ./export-html.csv
mv -f ./'Hey!'*.html ./template-html.html
echo ""

echo "******"
echo "Cleaning up the template-html.html file..."
echo "******"
# This is the get case to match
sed -i 's/http:\/\/xxxxxx/XXXXXX/g' template-html.html
sed -i 's/xxxxxx\//XXXXXX/g' template-html.html

# This is the get the NFT image correct
sed -i 's/<img decoding=async src="data:image\/webp;base64,UklGR.* height=467>/<img src="XXXXXXimage_htmlXXXXXX" alt="NFT Image">/g' template-html.html

# add internal comment
sed -i 's/Page saved with SingleFile/country: XXXXXXcountryXXXXXX \n card_group_lookup: XXXXXXcard_group_lookupXXXXXX \n geocords: XXXXXXgeocordsXXXXXX \n event_id: XXXXXXevent_idXXXXXX \n color_bkgd_hex: XXXXXXcolor_bkgd_hexXXXXXX \n color_card_hex: XXXXXXcolor_card_hexXXXXXX \n token_quantity: XXXXXXtoken_quantityXXXXXX \n price_in_usd: XXXXXXprice_in_usdXXXXXX \n price_in_eth: XXXXXXprice_in_ethXXXXXX/g' template-html.html 

# This WORKS!
# <meta http-equiv="Content-Security-Policy" content="default-src 'none'; font-src 'self' data:; img-src 'self' data: https://*.ipfs.dweb.link; style-src 'unsafe-inline'; media-src 'self' data:; script-src 'unsafe-inline' data:; object-src 'self' data:; frame-src 'self' data:;">

# This WORKS!
tmp_str="<meta http-equiv=content-security-policy.*>"
my_str="<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'none'; font-src 'self' data:; img-src 'self' data: http:\/\/\*\.ipfs\.dweb\.link; style-src 'unsafe-inline'; media-src 'self' data:; script-src 'unsafe-inline' data:; object-src 'self' data:; frame-src 'self' data:;\">"

sed -i "s/$tmp_str/$my_str/g" template-html.html

# Color the button!
tmp_str="href=http\:\/\/marketplace.nfts.givebasicneeds.org\/ style=border-radius:50px target=_blank"
my_str="href=http:\/\/marketplace.nfts.givebasicneeds.org\/ style=\"border-radius:50px;background-color:XXXXXXcolor_rarity_hexXXXXXX\" target=\"_blank\""

sed -i "s/$tmp_str/$my_str/g" template-html.html
echo ""

echo "******"
echo "Running csv-to-html.py script..."
echo "******"
python3 csv-to-html.py --csv-file-path ./export-html.csv --template-file-path ./template-html.html --output-directory ./html
python3 csv-to-html.py --csv-file-path ./export-html.csv --template-file-path ./template-test.html --output-directory ./html/test
echo ""

echo "******"
echo "This is how many files the ./html directory has in it: $(ls -l ./html/*.html | wc -l)"
echo "******"
echo ""

# Prompt the user with a question
read -p "Does the html file count match the token count? (yes/no) " yn

# Check the user's answer
case $yn in
    [Yy]*)
        # Run the command if the user answers yes
	echo "******"
	echo "Building html car file..."
	echo "******"
	ipfs-car pack ./html --output ./cars/html.car
	echo ""
	echo "*** Note: You must copy the ipfs URI above and paste it in the Google Sheet (NFT-Plan _lookup 'CID html' before making json files. Don't forget!"
        ;;
    [Nn]*)
        # Do nothing if the user answers no
	echo ""
        echo "Okay html files not used to create a new html.car file!"
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

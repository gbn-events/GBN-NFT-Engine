#!/bin/bash

echo "******"
echo "Cleaning current media files..."
echo "******"
rm ./car/media.car
rm ./media/*
echo ""

echo "******"
echo "Create index.html file so hashed images in the media.car can't be seen..."
echo "******"
echo "<html><head><title>Media</title></head><body></body></html>" > ./media/index.html
echo ""

echo "******"
echo "Unzipping media files..."
echo "******"
unzip -q ./media-zip/G24-png.zip -d ./media
unzip -q ./media-zip/G24-mp4.zip -d ./media
echo ""


echo "******"
echo "This is how many files the ./media/*.png directory has in it: $(ls -l ./media/*.png | wc -l)"
echo "This is how many files the ./media/*.mp4 directory has in it: $(ls -l ./media/*.mp4 | wc -l)"
echo "******"
echo ""

echo "******"
echo "Start processing secret images..."
echo "******"
ls -l ./secret/
echo ""

# Prompt the user with a question
read -p "Do you want to move the above secret hash name files into the media folder? (yes/no) " yn

# Check the user's answer
case $yn in
    [Yy]*)
	echo ""
        # Run the command if the user answers yes
	echo "******"
	echo "Copying secret into media..."
	echo "******"
        cp ./secret/* ./media
	echo ""
        ;;
    [Nn]*)
        # Do nothing if the user answers no
	echo ""
	echo "Okay... No files copied to the media folder."
        ;;
    *)
        # Exit the script if the user enters an invalid response
	echo "Invalid response."
        exit 1
        ;;
esac

echo "******"
echo "This is how many files the ./media/*.png directory has in it: $(ls -l ./media/*.png | wc -l)"
echo "This is how many files the ./media/*.mp4 directory has in it: $(ls -l ./media/*.mp4 | wc -l)"
echo "This is how many files the ./media/*.jpg directory has in it: $(ls -l ./media/*.jpg | wc -l)"
echo "******"
echo ""

# Prompt the user with a question
read -p "Do the (mp4/png/jpg) filenames above match the tokenIDs and secrets? (yes/no) " yn

# Check the user's answer
case $yn in
    [Yy]*)
        # Run the command if the user answers yes
	echo ""
	echo "******"
	echo "Building media car file..."
	echo "******"
	ipfs-car pack ./media --output ./cars/media.car
	echo ""
	echo "*** Note: You must copy the ipfs URI above and paste it in the Google Sheet (NFT-Plan _lookup 'CID media' before making json files. Don't forget!"
        ;;
    [Nn]*)
        # Do nothing if the user answers no
	echo ""
        echo "Okay media files not used to create a new media.car file!"
        ;;
    *)
        # Exit the script if the user enters an invalid response
	echo "Invalid response."
        exit 1
        ;;
esac
echo ""
echo "-------------------------------------------"
echo "Done with media..."
echo "-------------------------------------------"
echo ""







#!/bin/bash

echo ""
echo "Lets do this!"
echo ""
pwd 
echo ""
./mk-media.sh

# Prompt the user with a question
read -p "Have you created the new HTML export files with the new Media CID in the spreadsheet? (yes/no) " yn

# Check the user's answer
case $yn in
    [Yy]*)
	echo ""
        # Run the command if the user answers yes
	./mk-html.sh

	# Prompt the user with a question
	read -p "Have you created the new JSON export files with the new HTML CID in the spreadsheet? (yes/no) " yn
	
	# Check the user's answer
	case $yn in
	    [Yy]*)
		echo ""
		# Run the command if the user answers yes
		./mk-json.sh
		echo ""
		;;
	    [Nn]*)
		# Do nothing if the user answers no
		echo ""
		echo "Okay... No json files generated."
		;;
	    *)
		# Exit the script if the user enters an invalid response
		echo "Invalid response."
		exit 1
		;;
	esac
	echo "******"
	echo ""
        ;;
    [Nn]*)
        # Do nothing if the user answers no
	echo ""
	echo "Okay... No html or json files generated."
        ;;
    *)
        # Exit the script if the user enters an invalid response
	echo "Invalid response."
        exit 1
        ;;
esac
echo "******"
echo ""
echo "All Done."

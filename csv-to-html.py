import csv
import os

def generate_html_files(csv_file_path, template_file_path, output_directory):

    # Open the CSV file
    with open(csv_file_path, "r") as csv_file:
        csv_reader = csv.reader(csv_file)

        # Read the header row
        header = next(csv_reader)

        # Iterate over the rows in the CSV file
        for row in csv_reader:

            # Create the output HTML file path
            output_html_file_path = os.path.join(output_directory, f"{row[0]}.html")

            # Create the output HTML file if it doesn't exist
            if not os.path.exists(output_html_file_path):
                with open(output_html_file_path, "w") as html_file:

                    # Read the HTML template file
                    with open(template_file_path, "r") as template_file:
                        template = template_file.read()

                    #  id, name, description, image, animation_url, external_url, edition, target, focus, power_rating, occurrence, rarity, card_group_lookup, created_date, human_impact, geocords, event_id, color_rarity_hex, color_bkgd_hex, color_card_hex, blog_post,location_name, map, travel_points, youtube_url, image_html, animation_html, special_image, token_quantity, price_in_usd,price_in_eth,
                    # Replace the placeholders in the template with the CSV values
                    template = template.replace("XXXXXXidXXXXXX", row[0])
                    template = template.replace("XXXXXXnameXXXXXX", row[1])
                    template = template.replace("XXXXXXdescriptionXXXXXX", row[2])
                    template = template.replace("XXXXXXimageXXXXXX", row[3])
                    template = template.replace("XXXXXXanimation_urlXXXXXX", row[4])
                    template = template.replace("XXXXXXeditionXXXXXX", row[6])
                    template = template.replace("XXXXXXtargetXXXXXX", row[7])
                    template = template.replace("XXXXXXfocusXXXXXX", row[8])
                    template = template.replace("XXXXXXpower_ratingXXXXXX", row[9])
                    template = template.replace("XXXXXXoccurrenceXXXXXX", row[10])
                    template = template.replace("XXXXXXrarityXXXXXX", row[11])
                    template = template.replace("XXXXXXcard_group_lookupXXXXXX", row[12])
                    template = template.replace("XXXXXXcreated_dateXXXXXX", row[13])
                    template = template.replace("XXXXXXhuman_impactXXXXXX", row[14])
                    template = template.replace("XXXXXXgeocordsXXXXXX", row[15])
                    template = template.replace("XXXXXXevent_idXXXXXX", row[16])
                    template = template.replace("XXXXXXcolor_rarity_hexXXXXXX", row[17])
                    template = template.replace("XXXXXXcolor_bkgd_hexXXXXXX", row[18])
                    template = template.replace("XXXXXXcolor_card_hexXXXXXX", row[19])
                    template = template.replace("XXXXXXblog_postXXXXXX", row[20])
                    template = template.replace("XXXXXXlocation_nameXXXXXX", row[21])
                    template = template.replace("XXXXXXmapXXXXXX", row[22])
                    template = template.replace("XXXXXXtravel_pointsXXXXXX", row[23])
                    template = template.replace("XXXXXXyoutube_urlXXXXXX", row[24])
                    template = template.replace("XXXXXXimage_htmlXXXXXX", row[25])
                    template = template.replace("XXXXXXanimation_htmlXXXXXX", row[26])
                    template = template.replace("XXXXXXspecial_image_htmlXXXXXX", row[27])
                    template = template.replace("XXXXXXtoken_quantityXXXXXX", row[28])
                    template = template.replace("XXXXXXprice_in_usdXXXXXX", row[29])
                    template = template.replace("XXXXXXprice_in_ethXXXXXX", row[30])
                    
                    # Write the HTML template to the new HTML file
                    html_file.write(template)

    print("HTML files generated successfully.")


# Example usage:

if __name__ == "__main__":

    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("--csv-file-path", required=True, help="Path to the CSV file")
    parser.add_argument("--template-file-path", required=True, help="Path to the HTML template file")
    parser.add_argument("--output-directory", required=True, help="Path to the output directory")

    args = parser.parse_args()

    generate_html_files(args.csv_file_path, args.template_file_path, args.output_directory)

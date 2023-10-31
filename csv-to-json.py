import argparse
import csv
import json
import os

# Define copywrite for each token
COPYWRITE = ["CC BY-NC 4.0 Attribution-NonCommercial 4.0 International"]

# Properties: id, name, description, image, animation_url, external_url
# TRAITS: "edition", "target", "focus", "power_rating", "occurrence", "rarity"

TRAITS = ["edition", "target", "focus", "power_rating", "occurrence", "rarity"]

def display_type(csv_header):
  """Determines the display type of a CSV column header.

  Args:
    csv_header: A string representing the CSV column header.

  Returns:
    A string representing the display type of the CSV column header.
  """

  case_statement = {
    "power_rating": "number",
  }

  display_type = case_statement.get(csv_header, "string")

  return display_type

def generate_json_file(csv_row):
 """Generates a JSON file from a CSV row.

 Args:
  csv_row: A list of strings representing the CSV row.

 Returns:
  A Python dictionary representing the JSON object.
 """

 json_object = {}
 for i, csv_header in enumerate(csv_headers):
  if csv_header in TRAITS:
   if "attributes" not in json_object:
    json_object["attributes"] = []
   json_object["attributes"].append({
    "trait_type": csv_header,
    "display_type": display_type(csv_header),
    "value": csv_row[i]
   })
  else:
    json_object[csv_header] = csv_row[i]

 return json_object

def main():
 """Generates individual JSON files from the CSV file sample."""

 # Parse the command line arguments.
 parser = argparse.ArgumentParser()
 parser.add_argument("--input_file", type=str, required=True, help="The path to the input CSV file.")
 parser.add_argument("--output_directory", type=str, required=True, help="The path to the output directory.")
 parser.add_argument("--output_file_extension", type=str, default=".json", help="The output file extension.")
 args = parser.parse_args()

 # Get the input file path and output directory from the command line arguments.
 csv_input_file_path = args.input_file
 output_directory = args.output_directory
 output_file_extension = args.output_file_extension

 # Create the output directory if it does not exist.
 if not os.path.exists(output_directory):
  os.makedirs(output_directory)

 # Open the CSV input file.
 with open(csv_input_file_path, "r") as csv_file:
  csv_reader = csv.reader(csv_file)

  # Get the CSV headers.
  global csv_headers
  csv_headers = next(csv_reader)

  # Iterate over the CSV rows and generate JSON files.
  for csv_row in csv_reader:
   json_object = generate_json_file(csv_row)
   json_object["copywrite"] = COPYWRITE
  
   # Write the JSON object to a file.
   output_file_path = os.path.join(output_directory, f"{csv_row[0]}{output_file_extension}")
   with open(output_file_path, "w") as json_file:
    json.dump(json_object, json_file, indent=4)

if __name__ == "__main__":
 main()
 

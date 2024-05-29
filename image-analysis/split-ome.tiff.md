---
description: >-
  Python script which splits all ome.tiff files from input folder and saves them
  in output folder
---

# Split ome.tiff

`python3 split <input-folder> <output-folder>`

Notes:

1. You have to have the code below saved as a file `split`&#x20;
2. Have it executable by typing `chmod a+x split`

```
# run this in command line using python3 
import sys
import os
import tifffile

if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <input_folder> <output_folder>")
    sys.exit(1)
    
input_folder = sys.argv[1]
output_folder = sys.argv[2]

    # Check if the input folder exists
if not os.path.isdir(input_folder):
    print(f"Error: Input folder '{input_folder}' does not exist.")
    sys.exit(1)
    
    # Ensure the output folder exists, if not, create it
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

    print(f"Input folder: {input_folder}")
    print(f"Output folder: {output_folder}")

# Get a list of all OME-TIFF files in the input folder
tif_files = [f for f in os.listdir(input_folder) if f.endswith('.ome.tiff')]

# Loop through each OME-TIFF file
for tif_file in tif_files:
    tif_path = os.path.join(input_folder, tif_file)
    
    # Load the OME-TIFF image
    image = tifffile.imread(tif_path)
    
    # Split the channels
    for channel_idx in range(image.shape[0]):
        channel = image[channel_idx]
        
        # Save each channel as a separate image
        channel_name = f'{tif_file[:-9]}_c{channel_idx + 1}.tif'
        channel_path = os.path.join(output_folder, channel_name)
        tifffile.imwrite(channel_path, channel)
        print(f'Saved {channel_name}')
        
print('All channels saved successfully.')


```

# SPlit all ome.tiff images to channels

This is code from chatGPT to split ome.tiff images to separate channels and call them `image_c1, image_c2 ...` and so  on.

The downside of this script is that even if it does not do anything it still exits sucessfully

```python
# run this in command line using python3
import os
import tifffile

# Input and output directories
input_folder = 'path_to_input_folder'
output_folder = 'path_to_output_folder'

# Get a list of all OME-TIFF files in the input folder
tif_files = [f for f in os.listdir(input_folder) if f.endswith('.ome.tif')]

# Loop through each OME-TIFF file
for tif_file in tif_files:
    tif_path = os.path.join(input_folder, tif_file)
    
    # Load the OME-TIFF image
    image = tifffile.imread(tif_path)
    
    # Split the channels
    for channel_idx in range(image.shape[0]):
        channel = image[channel_idx]
        
        # Save each channel as a separate image
        channel_name = f'{tif_file[:-8]}_c{channel_idx + 1}.tif'
        channel_path = os.path.join(output_folder, channel_name)
        tifffile.imwrite(channel_path, channel)
        print(f'Saved {channel_name}')
        
print('All channels saved successfully.')

```

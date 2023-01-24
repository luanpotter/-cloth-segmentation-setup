# cloth-segmentation-setup

Basic setup to be able to run [levindabhi/cloth-segmentation](https://github.com/levindabhi/cloth-segmentation)  

## Instructions

 * Clone this repo on a linux machine (CUDA doesn't work on macos)

   ```bash
   git clone git@github.com:luanpotter/cloth-segmentation-setup.git
   ```

 * Create a `input-images` file on the repo root with a new-line separated list of URLs with the source images.

   Example:

   ```txt
   url.com/to/image1.png
   url.com/to/image2.png
   ```

 * Run `setup.sh` and then `./run.sh`:

   ```bash
   ./setup.sh
   ./run.sh
   ```

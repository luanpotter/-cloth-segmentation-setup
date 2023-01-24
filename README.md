# cloth-segmentation-setup

Basic setup to be able to run [levindabhi/cloth-segmentation](https://github.com/levindabhi/cloth-segmentation)  
Note: CUDA is not supported on mac-os

## Instructions

 * You will need a Linux machine with nvidia GPU attached. For example, on GCE you can create one like so:

   ```bash
     gcloud compute instances create <instance name> \
      --machine-type a2-highgpu-1g --zone us-east1-b --boot-disk-size 200GB \
      --image-family debian-11 --image-project debian-cloud \
      --maintenance-policy TERMINATE --restart-on-failure

    gcloud compute ssh <instance name>
   ```

 * Clone this repo

   ```bash
   sudo apt-get install -y git
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

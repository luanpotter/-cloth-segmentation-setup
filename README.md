# cloth-segmentation-setup

Basic setup to be able to run [levindabhi/cloth-segmentation](https://github.com/levindabhi/cloth-segmentation)

**Note**: Nvidia CUDA requires a Nvidia GPU and is not supported on macOS!

## Instructions

 * You will need a Linux machine with Nvidia GPU attached.

   For example, on GCE you can create `a2-highgpu-1g` with Debian 10 and 200GB of disk space:

   ```bash
     gcloud compute instances create <instance name> \
      --machine-type a2-highgpu-1g --zone us-east1-b --boot-disk-size 200GB \
      --image-family debian-10 --image-project debian-cloud \
      --maintenance-policy TERMINATE --restart-on-failure

    gcloud compute ssh <instance name>
   ```

 * Clone this repo

   ```bash
   sudo apt-get update && sudo apt-get install -y git
   git clone https://github.com/luanpotter/cloth-segmentation-setup.git
   ```

 * Create a `input-images` file on the repo root with a new-line separated list of URLs with the source images.

   Example:

   ```txt
   url.com/to/image1.png
   url.com/to/image2.png
   ```

   To upload:
   
   ```bash
     gcloud compute scp <local-file> nvidia-cuda:~/cloth-segmentation-setup/input-images
   ``` 

 * Run `setup.sh` and then `run.sh`:

   ```bash
   ./setup.sh
   ./run.sh
   ```

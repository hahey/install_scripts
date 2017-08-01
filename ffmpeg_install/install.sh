sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

sudo apt-get -y install autoconf automake build-essential

sudo apt-get -y install libass-dev libfreetype6-dev\
    libsdl2-dev libtheora-dev libtool libav-tools libva-dev libvpau-dev \
    libvorbis-dev libxcbl-dev libxcb-shm0-dev libxcb-xfixes0-dev

sudo apt-get -y install pkg-config texinfo wget zlib1g-dev

sudo apt-get -y install yasm nasm libx264-dev libx265-dev \
    libfdk-aac-dev libmp3lame-dev libopus-dev libbpx-dev

sudo apt-get -y install ffmpeg

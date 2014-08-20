set -x

sudo apt-get -y install libjpeg8-dev

PWD=`pwd`

mkdir ~/webcam
cd ~/webcam
wget http://hivelocity.dl.sourceforge.net/project/mjpg-streamer/mjpg-streamer/Sourcecode/mjpg-streamer-r63.tar.gz
tar -zxvf mjpg-streamer-r63.tar.gz
cd mjpg-streamer-r63
sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
make clean all

cd $PWD
sudo cp ./init.d/webcam /etc/init.d/webcam
sudo chmod +x /etc/init.d/webcam
sudo update-rc.d webcam defaults


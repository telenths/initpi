set -x

cd ~
sudo apt-get -y install python-dev

git clone https://github.com/doceme/py-spidev.git
cd py-spidev/
sudo python setup.py install

cd ~
sudo rm -R py-spidev

git clone https://github.com/adammhaile/RPi-LPD8806.git
cd RPi-LPD8806
sudo python setup.py install

cd ~
sudo rm -R RPi-LPD8806


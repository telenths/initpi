set -x

cp ./.bashrc ~/
chmod 644 ~/.bashrc
sudo cp ./interfaces /etc/network/interfaces
sudo cp ./resolv.conf /etc/resolv.conf

git config --global user.email "telenths@gmail.com"
git config --global user.name "elvin.hu"

sudo apt-get -y update
sudo apt-get -y upgrade
sudo rpi-update



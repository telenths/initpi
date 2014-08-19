set -x

cp ./.bashrc ~/
chmod 644 ~/.bashrc
sudo cp ./interfaces /etc/network/interfaces
sudo cp ./resolv.conf /etc/resolv.conf


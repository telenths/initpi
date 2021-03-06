set -x

sudo apt-get -y install libssl-dev libavahi-client-dev libasound2-dev

git clone git://github.com/abrasive/shairport.git
cd shairport
sudo ./configure
sudo make
sudo make install

sudo cp ./scripts/debian/init.d/shairport /etc/init.d/
sudo cp ./scripts/debian/logrotate.d/shairport /etc/logrotate.d/
sudo cp ../default/shairport /etc/default/

sudo update-rc.d shairport defaults

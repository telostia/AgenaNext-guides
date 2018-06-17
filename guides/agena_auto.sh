#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install git -y
sudo apt-get install nano -y
sudo apt-get install curl -y
sudo apt-get install pwgen -y
sudo apt-get install wget -y
sudo apt-get install build-essential libtool automake autoconf -y
sudo apt-get install autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libgmp3-dev libevent-dev bsdmainutils libboost-all-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
cd
#get wallet files
wget https://raw.githubusercontent.com/telostia/AgenaNext-guides/master/wallet/linux/linux_agena.tar.gz
tar -xvf linux_agena.tar.gz
chmod +x agena*
cp agena* /usr/local/bin



#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click ${NONE}";
read MNKEY

EXTIP=`wget -qO- eth0.me`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";
echo -e "${GREEN}Make a backup of wallet.dat incase if already existed to /root/wallet.bak ${NONE}";
cp -r -p $HOME/.agencore/wallet.dat /root/wallet.bak
rm -rf $HOME/.agenacore
sudo mkdir $HOME/.agenacore

printf "addnode=144.202.58.228:1984\naddnode=13.58.43.14:1984\naddnode=198.187.30.178:1984\naddnode=23.95.226.17:1984\naddnode=144.202.104.5:1984\naddnode=209.250.246.24:1984\naddnode=5.135.76.217:1984\naddnode=199.247.25.189:1984\n\nrpcuser=agena51345random\nrpcpassword=$PASSW\nrpcport=1977\nrpcallowip=127.0.0.1\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nexternalip=$EXTIP:1984\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.agenacore/agena.conf


agenad -daemon
watch agena-cli getinfo


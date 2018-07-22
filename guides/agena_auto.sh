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
#get ip
sudo apt install libwww-perl -y

cd
#get wallet files
wget https://raw.githubusercontent.com/telostia/AgenaNext-guides/master/wallet/linux/agena-linux.tar.gz
tar -xvf agena-linux.tar.gz
rm agena-linux.tar.gz
rm agena_auto.sh
chmod +x agena*
cp agena* /usr/local/bin
rm agena*

#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click and press ENTER ${NONE}";
read MNKEY

EXTIP=`lwp-request -o text checkip.dyndns.org | awk '{ print $NF }'`
USER=`pwgen -1 20 -n`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";
echo -e "${GREEN}Make a backup of wallet.dat incase if already existed to /root/wallet.bak ${NONE}";
sudo mkdir $HOME/.agenacore

printf "addnode=45.63.119.20:1984:1984\naddnode=63.209.33.237:1984\naddnode=173.212.238.28:1984\naddnode=192.210.223.201:1984\naddnode=207.148.72.43:1984\n\nrpcuser=$USER\nrpcpassword=$PASSW\nrpcport=1977\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nexternalip=$EXTIP\nbind=$EXTIP:1984\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.agenacore/agena.conf



agenad -daemon
watch agena-cli getinfo


#!/bin/bash

# setup EC2 server with requisite libs
sudo apt-get --yes --force-yes update
sudo apt-get --yes --force-yes install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get --yes --force-yes install --no-install-recommends libboost-all-dev

# python dependencies
sudo apt-get --yes --force-yes install libatlas-base-dev
sudo apt-get --yes --force-yes install python-dev

# Dependencies for Ubuntu 14.04
sudo apt-get --yes --force-yes install libgflags-dev libgoogle-glog-dev liblmdb-dev

#######################################################
############## ANACONDA INSTALLATION  #################
#######################################################

# install anaconda python
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-2.3.0-Linux-x86_64.sh

bash Anaconda-2.3.0-Linux-x86_64.sh -b

# delete anaconda install script
rm Anaconda-2.3.0-Linux-x86_64.sh

# update paths for current window
export PATH=/home/ubuntu/anaconda/bin:$PATH >> ~/.bashrc
source ~/.bashrc

#######################################################
################ CAFFE INSTALLATION  ##################
#######################################################

# download caffe
cd ~/
git clone https://github.com/BVLC/caffe.git

# copy over the Makefile.config file
cp caffe-ubuntu-14.04/Makefile.config caffe/

# install caffe
cd caffe

# compile caffe code and test
make all
make test
make runtest

#######################################################
############### PYCAFFE INSTALLATION  #################
#######################################################

cd python

# install other python requirements
for req in $(cat requirements.txt); do pip install $req; done

# compile pycaffe code
cd ..
make pycaffe

# add pycaffe to python path
echo 'export PYTHONPATH="/home/ubuntu/caffe/python:$PYTHONPATH"' >> ~/.bashrc

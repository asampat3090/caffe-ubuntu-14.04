# setup EC2 server with requisite libs
sudo apt-get update
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev

# python dependencies
sudo apt-get install libatlas-base-dev
sudo apt-get install python-dev

# Dependencies for Ubuntu 14.04
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev

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

# install python
cd python

# install anaconda
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-2.3.0-Linux-x86_64.sh

bash Anaconda-2.3.0-Linux-x86_64.sh

# delete anaconda install script
rm Anaconda-2.3.0-Linux-x86_64.sh

# install other python requirements
for req in $(cat requirements.txt); do pip install $req; done

# compile pycaffe code
cd ..
make pycaffe

# add pycaffe to python path
echo 'export PYTHONPATH="/home/ubuntu/caffe/python:$PYTHONPATH"' >> ~/.bashrc
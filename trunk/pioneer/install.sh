#for pioneer robot
#using ubuntu 12.04 Server
#install ros-fuerte
#export http_proxy="http://proxy2.intra.rma.ac.be:3128"
#export https_proxy="http://proxy2.intra.rma.ac.be:3128"
#export ftp_proxy="http://proxy2.intra.rma.ac.be:3128"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'

wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

sudo apt-get update

sudo apt-get install -y ros-fuerte-ros-comm

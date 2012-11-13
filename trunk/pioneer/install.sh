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
sudo apt-get -y install ros-fuerte-common
sudo apt-get -y install ros-fuerte-diagnostics
sudo apt-get -y install ros-fuerte-diagnostics-monitor


echo "source /opt/ros/fuerte/setup.bash" >> ~/.bashrc
. ~/.bashrc



sudo apt-get -y install subversion
#is there a proxy? svn may not be configured

                svnConfigFile="/etc/subversion/servers"
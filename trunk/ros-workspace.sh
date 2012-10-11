#! /bin/bash

sudo apt-get -y install python-pip
sudo pip install -U rosinstall --proxy=$http_proxy
sudo pip install -U rosinstall_shellcompletion --proxy=$http_proxy
mkdir $HOME/work_ros_electric
rosws init $HOME/ros_electric /opt/ros/electric
echo "source $HOME/ros_electric/setup.bash" >> $HOME/.bashrc
source $HOME/ros_electric/setup.bash

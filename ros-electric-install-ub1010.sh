#! /bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu maverick main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-electric-ros-base
echo "source /opt/ros/electric/setup.bash" >> $HOME/.bashrc
source /opt/ros/electric/setup.bash

#! /bin/bash
rosDistributinoName="electric"
rosWorkspaceDir="$HOME/ros_$rosDistributinoName"

sudo apt-get install git

rosws set ${rosWorkspaceDir}/ardrone_autonomy --git https://github.com/AutonomyLab/ardrone_autonomy.git -y
rosws update ardrone_autonomy
source ${rosWorkspaceDir}/setup.bash
rosdep install pmd_camcube_3_ros_pkg 
roscd ardrone_autonomy
./build_sdk.sh
ls ./lib
rosmake ardrone_autonomy

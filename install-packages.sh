#! /bin/bash
rosDistributinoName="electric"
rosWorkspaceDir="$HOME/ros_$rosDistributinoName"

rosws set ${rosWorkspaceDir}/theodor --svn http://rma-ros-install.googlecode.com/svn/trunk/packages/theodor -y
rosws update theodor
source ${rosWorkspaceDir}/setup.bash
rosdep install theodor
rosmake theodor 

rosws set ${rosWorkspaceDir}/wu_ptu --svn https://wu-robotics.googlecode.com/svn/branches/stable/wu_ptu -y
rosws update wu_ptu
source ${rosWorkspaceDir}/setup.bash
rosdep install ptu46
rosmake ptu46 
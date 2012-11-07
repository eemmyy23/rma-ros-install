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

rosws set ${rosWorkspaceDir}/robotV1 --svn http://rma-ros-install.googlecode.com/svn/trunk/packages/robotV1 -y
rosws update robotV1
source ${rosWorkspaceDir}/setup.bash
rosdep install robotV1
rosmake robotV1

rosws set ${rosWorkspaceDir}/imu_position --svn http://rma-ros-install.googlecode.com/svn/trunk/packages/imu_position -y
rosws update imu_position
source ${rosWorkspaceDir}/setup.bash
rosdep install imu_position
rosmake imu_position


rosws set ${rosWorkspaceDir}/usb_cam --svn http://svn.code.sf.net/p/bosch-ros-pkg/code/trunk/stacks/bosch_drivers/usb_cam -y
rosws update usb_cam
source ${rosWorkspaceDir}/setup.bash
rosdep install usb_cam
rosmake usb_cam

rosws set ${rosWorkspaceDir}/mjpeg_server --svn http://svn.code.sf.net/p/bosch-ros-pkg/code/trunk/stacks/mjpeg_server -y
rosws update mjpeg_server
source ${rosWorkspaceDir}/setup.bash
rosdep install mjpeg_server
rosmake mjpeg_server


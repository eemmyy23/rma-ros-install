#! /bin/bash
rosDistributinoName="electric"
rosWorkspaceDir="$HOME/ros_$rosDistributinoName"

sudo groupadd usb
sudo usermod -aG usb `whoami`
sudo su
echo 'BUS!="usb", SUBSYSTEM!=="usb_device", ACTION!="add", GOTO="kcontrol_rules_end"' >/etc/udev/rules.d/56-pmd.rules
echo 'SYSFS{idVendor}=="1c28", SYSFS{idProduct}=="c003", MODE="666", GROUP="usb"' >>/etc/udev/rules.d/56-pmd.rules
echo 'LABEL="kcontrol_rules_end"' >>/etc/udev/rules.d/56-pmd.rules
exit

rosws set ${rosWorkspaceDir}/pmd_camcube_3 --svn http://rma-ros-install.googlecode.com/svn/trunk/packages/pmd_camcube_3 -y
rosws update pmd_camcube_3
source ${rosWorkspaceDir}/setup.bash
rosdep install pmd_camcube_3_ros_pkg  ### sudo apt-get install ros-electric-plc16
echo "export PMDDIR=${rosWorkspaceDir}/pmd_camcube_3/pmd_camcube_3_ros_pkg/PMDSDK2" >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH="/home/emi/ros_electric/pmd_camcube_3/pmd_camcube_3_ros_pkg/lib:${LD_LIBRARY_PATH}" >> $HOME/.bashrc

source $HOME/.bashrc
rosmake pmd_camcube_3_ros_pkg

#! /bin/bash
rosDistributinoName="electric"
rosWorkspaceDir="$HOME/ros_$rosDistributinoName"

sudo apt-get -y install python-pip
sudo pip install -U rosinstall --proxy=$http_proxy
sudo pip install -U rosinstall_shellcompletion --proxy=$http_proxy


if [ -d "$rosWorkspaceDir" ]; then 
echo "do you want to override"
	if [ -L "$rosWorkspaceDir" ]; then
		rm "$rosWorkspaceDir"
	else
		rmdir "$rosWorkspaceDir"
	fi
	mkdir $rosWorkspaceDir
fi

mkdir $rosWorkspaceDir
rosws init $rosWorkspaceDir /opt/ros/$rosDistributinoName
echo "source ${rosWorkspaceDir}/setup.bash" >> $HOME/.bashrc
source ${rosWorkspaceDir}/setup.bash


sudo apt-get -y install ros-electric-geometry
sudo apt-get -y install ros-electric-common


rosws set ${rosWorkspaceDir}/wu_ptu --svn https://wu-robotics.googlecode.com/svn/branches/stable/wu_ptu -y
rosws update wu_ptu
source ${rosWorkspaceDir}/setup.bash
rosdep install ptu46
rosmake ptu46 




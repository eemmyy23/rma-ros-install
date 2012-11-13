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

echo "source /opt/ros/fuerte/setup.bash" >> ~/.bashrc
. ~/.bashrc



sudo apt-get -y install subversion
#is there a proxy? svn may not be configured
if [ -n "$http_proxy" ]; then
    echo "proxy is set: $http_proxy"
                tmp=`echo -n ${http_proxy} | cut -d/ -f3`
                host=`echo $tmp | cut -d: -f1`
                port=`echo $tmp | cut -d: -f2`    
                svnConfigFile="/etc/subversion/servers"
    if [ `cat $svnConfigFile | grep -c $host` -eq 0 ];then
        echo "proxy is not set for svn"
        sudo echo "http-proxy-host = $host" >> $svnConfigFile
        sudo echo "http-proxy-port = $port" >> $svnConfigFile
        echo "$svnConfigFile was configured with your proxy settings"
    else
        echo "proxy settings are already applied for svn"
    fi
else
    echo '$http_proxy is not set'
fi
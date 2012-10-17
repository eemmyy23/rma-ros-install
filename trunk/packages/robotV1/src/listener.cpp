#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/Joy.h"
#include <sstream>
    float mv,mv1,rt,rt1;
    std_msgs::String pubMsg;
    ros::Publisher theodor_pub;
    bool bStop;
    bool bStart;
void joyCallback(const sensor_msgs::Joy::ConstPtr& msg)
{
    pubMsg.data = "";
    bStop = msg->buttons[1];    
    bStart = msg->buttons[0]; 
    if(bStop ^ bStart){
	    if(bStop) pubMsg.data = "MP150RT150";
	    if(bStart) pubMsg.data = "MV150RT150";
	    ROS_INFO("%s", pubMsg.data.c_str());
	    theodor_pub.publish(pubMsg);
    }
    int speed = 10;
    mv = int(150+msg->axes[5]*speed*-1);    
    rt = int(150+msg->axes[0]*speed);  
    if(mv != mv1 || rt != rt1){
	    std::stringstream ss;
	    ss << "MV" << mv << "RT" << rt;
	    pubMsg.data = ss.str();
	    ROS_INFO("---------------------------");
	    ROS_INFO("Speed: [%f]", msg->axes[5]);
	    ROS_INFO("Rotation: [%f]", msg->axes[0]);
	    ROS_INFO("%s", pubMsg.data.c_str());
	    theodor_pub.publish(pubMsg);
            mv1=mv;
            rt1=rt;
    }
  
}
// %EndTag(CALLBACK)%

int main(int argc, char **argv)
{  
  ros::init(argc, argv, "listener");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("/joy", 1000, joyCallback);
  
  theodor_pub = n.advertise<std_msgs::String>("uc0Command", 1000);  

  ros::spin();

  return 0;
}


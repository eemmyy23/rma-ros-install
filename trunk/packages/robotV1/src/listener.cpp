#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Empty.h"
#include "sensor_msgs/Joy.h"
#include "sensor_msgs/JointState.h"
#include "geometry_msgs/Twist.h"
#include <sstream>

    std_msgs::String pubMsg;
    ros::Publisher theodor_pub, ptu_pub, ardrone_takeoff_pub, ardrone_land_pub, ardrone_reset_pub, ardrone_cmd_pub ;
     
  float mv,mv1,rt,rt1;
 bool bStop, bStart, bSwitch1, bSwitch2;
		int mode = 0;
int speed = 10;//for theodor
double tmin, tmax, pmin, pmax;
double tsmin, tsmax, psmin, psmax;
float pcur, tcur;


double max_speed = 0.500; // m/second
double max_turn = 60.0*M_PI/180.0; // rad/second

void posRcvd(const sensor_msgs::JointState::ConstPtr& msg) {
    pcur = msg->position[0];
    tcur = msg->position[1];
}

void movePTU(const sensor_msgs::Joy::ConstPtr& msg){
    float x = msg->axes[0], y = msg->axes[1];
    float pan, pvel, tilt, tvel;
    float dead = 0.15;
		bool publishP=true, publishT=true;
			if (msg->buttons[0]) {
            pan = 0;
            tilt = 0;
            pvel = psmax;
            tvel = tsmax;
        } else {
            if (x<-dead)
                pan = pmin;
            else if (x>dead)
                pan = pmax;
            else {
                pan = pcur;
								publishP=false;
						}
            if (y<-dead)
                tilt = tmin;
            else if (y>dead)
                tilt = tmax;
            else{
                tilt = tcur;
								publishT=false;
						}	
            float xx = x*x, yy = y*y;
            pvel = xx*(psmax-psmin)+psmin;
            tvel = yy*(tsmax-tsmin)+tsmin;
				if(!publishP)pvel=0;
				if(!publishT)tvel=0;
        }

        sensor_msgs::JointState joint_cmd;
        joint_cmd.header.stamp = ros::Time::now();
        joint_cmd.name.resize(2);
        joint_cmd.position.resize(2);
        joint_cmd.velocity.resize(2);
				
        joint_cmd.name[0] ="head_pan_joint";
        joint_cmd.position[0] = pan;
        joint_cmd.velocity[0] = pvel;
				
        joint_cmd.name[1] ="head_tilt_joint";
			
        joint_cmd.position[1] = tilt;
        joint_cmd.velocity[1] = tvel;
				      
				ptu_pub.publish(joint_cmd) ;
}

void moveTheodor(const sensor_msgs::Joy::ConstPtr& msg){
if(bStop ^ bStart){
			  if(bStop) pubMsg.data = "MP150RT150";
			  if(bStart) pubMsg.data = "MV150RT150";
			  ROS_INFO("%s", pubMsg.data.c_str());
			  theodor_pub.publish(pubMsg);
		  }
		  mv = int(150+msg->axes[5]*speed*-1);    
		  rt = int(150+msg->axes[2]*speed);  
		  if(mv != mv1 || rt != rt1){
			  std::stringstream ss;
			  ss << "MV" << mv << "RT" << rt;
			  pubMsg.data = ss.str();
			  ROS_INFO("---------------------------");
			  ROS_INFO("Speed: [%f]", msg->axes[5]);
			  ROS_INFO("Rotation: [%f]", msg->axes[2]);
			  ROS_INFO("%s", pubMsg.data.c_str());
			  theodor_pub.publish(pubMsg);
				mv1=mv;
				rt1=rt;
    	}
}

void ctrlArdrone(const sensor_msgs::Joy::ConstPtr& msg){
	if(bStop ^ bStart){
					if(bStop) {
						ardrone_land_pub.publish(std_msgs::Empty());
						ROS_INFO("Ardrone land");
					}
					if(bStart){
					 ardrone_takeoff_pub.publish(std_msgs::Empty());
						ROS_INFO("Ardrone takeoff");
					}
				}

	if(msg->buttons[3]){
				ardrone_reset_pub.publish(std_msgs::Empty());
						ROS_INFO("Ardrone reset");
		}
	
	geometry_msgs::Twist ardrone_mv;
	ardrone_mv.linear.x = msg->axes[5]; 	// move backward forward
  ardrone_mv.linear.y = msg->axes[2];		// move right move left
  ardrone_mv.linear.z = msg->axes[1];		// move down move up
  ardrone_mv.angular.z = msg->axes[0];	//turn left turn right
	ardrone_cmd_pub.publish(ardrone_mv);	


}


void joyCallback(const sensor_msgs::Joy::ConstPtr& msg)
{
    pubMsg.data = "";
    bStop = msg->buttons[1];    
    bStart = msg->buttons[0]; 
		bSwitch1 = msg->buttons[6]; 
		bSwitch2 = msg->buttons[7]; 
		if(bSwitch1 && bSwitch2) {
    	mode = msg->buttons[0]*1+msg->buttons[1]*2+msg->buttons[2]*3+msg->buttons[3]*4;
			ROS_INFO("---------------------------");
	    ROS_INFO("NEW DEVICE SELECTED");
	    ROS_INFO("THE NEW MODE IS %d",mode);
			return;		
		}

		switch (mode){
		case 1:
			moveTheodor(msg);
		break;
		case 2:
			movePTU(msg);
		break;  
		case 3:
		ctrlArdrone(msg);
		break;
		default:
			movePTU(msg);
			moveTheodor(msg);
		break;	
	}
  
}
// %EndTag(CALLBACK)%

int main(int argc, char **argv){  
  ros::init(argc, argv, "listener");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("/joy", 1000, joyCallback);
  
  theodor_pub = n.advertise<std_msgs::String>("uc0Command", 1000);  
	
	ardrone_takeoff_pub = n.advertise<std_msgs::Empty>("ardrone/takeoff", 1000);
	ardrone_land_pub = n.advertise<std_msgs::Empty>("ardrone/land", 1000);
	ardrone_reset_pub = n.advertise<std_msgs::Empty>("ardrone/reset", 1000);
	ardrone_cmd_pub = n.advertise<geometry_msgs::Twist>("cmd_vel", 1000);

      ptu_pub = n.advertise<sensor_msgs::JointState>("/ptu/cmd", 1);
	n.param("/ptu/max_pan", pmax, 2.5);
    n.param("/ptu/min_pan", pmin, -2.5);
    n.param("/ptu/max_tilt", tmax, 0.3);
    n.param("/ptu/min_tilt", tmin, -0.75);
    n.param("/ptu/min_tilt_speed", tsmin, 0.1);
    n.param("/ptu/max_tilt_speed", tsmax, 3.5);
    n.param("/ptu/min_pan_speed", psmin, 0.1);
    n.param("/ptu/max_pan_speed", psmax, 3.5);
    pcur = tcur = 0;

	    ros::Subscriber sub2=n.subscribe<sensor_msgs::JointState>("/ptu/state", 1, posRcvd);
  ros::spin();


  return 0;
}


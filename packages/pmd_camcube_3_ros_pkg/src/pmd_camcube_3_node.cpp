/******************************************************************************
 * Copyright (c) 2011
 * GPS GmbH
 *
 * Author:
 * Pinaki Sunil Banerjee
 *
 *
 * This software is published under a dual-license: GNU Lesser General Public
 * License LGPL 2.1 and BSD license. The dual-license implies that users of this
 * code may choose which terms they prefer.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * * Neither the name of Locomotec nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License LGPL as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version or the BSD license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License LGPL and the BSD license for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License LGPL and BSD license along with this program.
 *
 ******************************************************************************/
#define SOURCE_PARAM ""
#define PROC_PARAM ""
#include <pmdsdk2.h>


#include <stdio.h>
#include <time.h>
#include <sstream>

#include <ros/ros.h>
#include <tf/transform_listener.h>
#include <ros/publisher.h>

//#include "CImg.h"
//using namespace cimg_library;
//#include <unistd.h>

#include <pmd_camcube_3_ros_pkg/pmd_camcube_3_ros_pkgConfig.h>
#include <dynamic_reconfigure/server.h>

//#include <std_msgs/Float32.h>
#include <pmd_camcube_3_ros_pkg/Distance.h>
#include <pmd_camcube_3_ros_pkg/Pixels.h>
//typedef pcl::PointCloud<pcl::PointXYZI> PointCloud;

/**
 * Global Parameter Declarations
 */
#define cimg_OS 0
#define cimg_display 0
/**
 * Camera Configuration Parameters
 */
int integrationTime;

int modulationFrequency;
bool AtLeastFrequency;
bool AtMostFrequency;

bool StatisticalNoiseFilterOn;
int NoiseFilteringNoOfNeighbours;
float StdDevMulThreshold;

bool AmplitudeFilterOn;
float AmplitudeThreshold;

int noOfRows;
int noOfColumns;

/**
 * Camera Driver Parameters
 */
PMDHandle hnd;
int res;
char err[128];

/**
 * ROS Parameters
 */

bool dataPublished;
ros::Publisher pub_non_filtered;
ros::Publisher pub_filtered;
ros::Publisher pub_outliers;
ros::Publisher depth_map;
ros::Publisher depth_img;

 pmd_camcube_3_ros_pkg::Distance pmd_data;
 pmd_camcube_3_ros_pkg::Pixels pmd_img;

 int map_depth_to_grey(float dist,float maxDist){
 
   int pixel = (int)(dist * 255 / maxDist);
   if (pixel>255) return 255;
   return pixel;
  
 }
 
void callback(pmd_camcube_3_ros_pkg::pmd_camcube_3_ros_pkgConfig &config, uint32_t level)
{
	integrationTime = config.Integration_Time;

	modulationFrequency = config.Modulation_Frequency;
	AtLeastFrequency = config.At_Least;
	AtMostFrequency = config.At_Most;

	StatisticalNoiseFilterOn = config.Statistical_Noise_Filter_On;
	NoiseFilteringNoOfNeighbours = config.Noise_Filtering_NoOfNeighbours;
	StdDevMulThreshold = (float)config.Std_Dev_Mul_Threshold;

	AmplitudeFilterOn = config.Amplitude_Filter_On;
	AmplitudeThreshold = config.Amplitude_Threshold;

}

/**
 * Initialize the camera and initial parameter values. Returns 1 if properly initialized.
 */
int initialize(int argc, char *argv[],ros::NodeHandle nh){
	/*
	 * Inital Setup for parameters
	 */
	integrationTime = 23800;//238 normal
	modulationFrequency = 20000000;
	AtLeastFrequency = false;
	AtMostFrequency = false;

	StatisticalNoiseFilterOn = false;
	NoiseFilteringNoOfNeighbours = 30;
	StdDevMulThreshold = 0.4;

	AmplitudeFilterOn = false;
	AmplitudeThreshold = 0;



	/*
	 * Camera Initialization
	 */
	std::stringstream sourcePluginLocation, procPluginLocation;
	sourcePluginLocation.clear();
	sourcePluginLocation.clear();
	sourcePluginLocation << PMD_PLUGIN_DIR << "camcube3";
	procPluginLocation << PMD_PLUGIN_DIR << "camcubeproc";


	res = pmdOpen (&hnd, sourcePluginLocation.str().c_str(), SOURCE_PARAM, procPluginLocation.str().c_str(), PROC_PARAM);

	if (res != PMD_OK)
	{
		pmdGetLastError (0, err, 128);
		fprintf (stderr, "Could not connect: \n%s\n", err);
		return 0;
	}

	res = pmdUpdate (hnd);
	if (res != PMD_OK)
	{
		pmdGetLastError (hnd, err, 128);
		fprintf (stderr, "Could transfer data: %s\n", err);
		pmdClose (hnd);
		return 0;
	}


	PMDDataDescription dd;

	res = pmdGetSourceDataDescription (hnd, &dd);
	if (res != PMD_OK)
	{
		pmdGetLastError (hnd, err, 128);
		fprintf (stderr, "Could get data description: %s\n", err);
		pmdClose (hnd);
		return 0;
	}

	if (dd.subHeaderType != PMD_IMAGE_DATA)
	{
		fprintf (stderr, "Source data is not an image!\n");
		pmdClose (hnd);
		return 0;
	}
	noOfRows = dd.img.numRows;
	noOfColumns = dd.img.numColumns;

	/*
	 * ROS Node Initialization
	 *///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
	depth_map = nh.advertise<pmd_camcube_3_ros_pkg::Distance>("pmd3/meters", 1000);
        depth_img = nh.advertise<pmd_camcube_3_ros_pkg::Pixels>("pmd3/pixels", 1000);
	 /*
	pub_non_filtered = nh.advertise<PointCloud> ("depth_non_filtered", 1);
	pub_filtered = nh.advertise<PointCloud> ("depth_filtered", 1);
	pub_outliers = nh.advertise<PointCloud> ("depth_outliers", 1);
	 */
	dataPublished=true;
	return 1;
}

/**
 * Publishes the point clod passed as a parameter
 
void publishCloud(pcl::PointCloud<pcl::PointXYZI>::Ptr cloud_ptr , ros::Publisher pub){
	PointCloud::Ptr msg (new PointCloud);
	msg->header.frame_id = "tf_pmd_camcube";
	msg->height = 1;
	msg->width = cloud_ptr->points.size();
	for  (unsigned int i =0; i< cloud_ptr->points.size() ; i++)
		msg->points.push_back ( pcl::PointXYZI(cloud_ptr->points[i]) );
	msg->header.stamp = ros::Time::now ();
	pub.publish (msg);
}
*/

/**
 * Publish the data based on set up parameters.
 */
int publishData(){

	/*
	 * Set the integration time
	 */
	res = pmdSetIntegrationTime (hnd, 0, integrationTime);
	if (res != PMD_OK)
	{
		pmdGetLastError (hnd, err, 128);
		fprintf (stderr, "Could set integration time: %s\n", err);
		pmdClose (hnd);
		return 0;
	}

	/*
	 * Update Camera settings
	 */
	res = pmdUpdate (hnd);
	if (res != PMD_OK)
	{
		pmdGetLastError (hnd, err, 128);
		fprintf (stderr, "Could transfer data: %s\n", err);
		pmdClose (hnd);
		return 0;
	}

	/*
	 * Obtain PointClouds
	 */
	 /*
	float * cartesianDist = new float [noOfRows * noOfColumns * 3];
	res = pmdGet3DCoordinates (hnd, cartesianDist, noOfColumns * noOfRows * 3 * sizeof (float));
	if (res != PMD_OK)
	{
		pmdGetLastError (hnd, err, 128);
		fprintf (stderr, "Could get cartesian coordinates: %s\n", err);
		pmdClose (hnd);
		return 0;
	}
	*/
	/* emi*
	 * Obtain Distance Values
	 */
	pmd_data.Distances.resize(noOfRows * noOfColumns);
	pmd_img.Pixels.resize(pmd_data.Distances.size());
	pmd_img.width = noOfColumns;
	pmd_img.height = noOfRows;
	pmd_img.maxDist = 0;
	pmd_img.maxPixel = 0;

	float * distances = new float [pmd_data.Distances.size()];

		res = pmdGetDistances (hnd, distances, noOfRows * noOfColumns * sizeof (float));
		if (res != PMD_OK)
		{
			pmdGetLastError (hnd, err, 128);
			fprintf (stderr, "Could get distance values: %s\n", err);
			pmdClose (hnd);
			return 1;
		}

	/*
	 * Obtain Amplitude Values
	 */
	 /*
	float * amplitudes = new float [noOfRows * noOfColumns];

		res = pmdGetAmplitudes (hnd, amplitudes, noOfRows * noOfColumns * sizeof (float));
		if (res != PMD_OK)
		{
			pmdGetLastError (hnd, err, 128);
			fprintf (stderr, "Could get amplitude values: %s\n", err);
			pmdClose (hnd);
			return 1;
		}
*/
	/*
	 * Creating the pointcloud
	 */
	 /*
	pcl::PointCloud<pcl::PointXYZI>::Ptr cloud_ptr (new pcl::PointCloud<pcl::PointXYZI>);
	pcl::PointCloud<pcl::PointXYZI>::Ptr cloud_ptr_filtered (new pcl::PointCloud<pcl::PointXYZI>);
	pcl::PointCloud<pcl::PointXYZI>::Ptr cloud_ptr_outliers (new pcl::PointCloud<pcl::PointXYZI>);

	// Fill in the cloud data
	cloud_ptr->width    = noOfColumns*noOfRows;
	cloud_ptr->height   = 1;
	cloud_ptr->is_dense = false;
	cloud_ptr->points.resize (cloud_ptr->width * cloud_ptr->height);

	int countWidth=0;

	if(AmplitudeFilterOn){


		for (size_t i = 0; i < cloud_ptr->points.size (); ++i)
		{
			if(amplitudes[i]>AmplitudeThreshold){
				cloud_ptr->points[i].x = cartesianDist[(i*3) + 0];
				cloud_ptr->points[i].y = cartesianDist[(i*3) + 1];
				cloud_ptr->points[i].z = cartesianDist[(i*3) + 2];
				cloud_ptr->points[i].intensity = amplitudes[i];
				countWidth++;
			}
		}

	} else {

		for (size_t i = 0; i < cloud_ptr->points.size (); ++i)
		{
			cloud_ptr->points[i].x = cartesianDist[(i*3) + 0];
			cloud_ptr->points[i].y = cartesianDist[(i*3) + 1];
			cloud_ptr->points[i].z = cartesianDist[(i*3) + 2];
			cloud_ptr->points[i].intensity = amplitudes[i];
			countWidth++;
		}
	}

	cloud_ptr->width    = countWidth;
	cloud_ptr->points.resize (cloud_ptr->width * cloud_ptr->height);
*/
	/*
	 * Filtering the Data
	 */
/*
	 if(StatisticalNoiseFilterOn){
		 pcl::StatisticalOutlierRemoval<pcl::PointXYZI> sor;
		 sor.setInputCloud (cloud_ptr);
		 sor.setMeanK (30);
		 sor.setStddevMulThresh (0.4);
		 sor.filter (*cloud_ptr_filtered);
		 sor.setNegative (true);
		 sor.filter (*cloud_ptr_outliers);
	 }
*/
	 /*
	  * Publishing the messages
	  */
/*
	 if(AmplitudeFilterOn){

		 if(StatisticalNoiseFilterOn){
			 publishCloud(cloud_ptr_filtered, pub_filtered);
			 publishCloud(cloud_ptr_outliers, pub_outliers);
		 } else {
			 publishCloud(cloud_ptr, pub_filtered);
		 }


	 } else {

		 if(StatisticalNoiseFilterOn){
			 publishCloud(cloud_ptr_filtered, pub_filtered);
			 publishCloud(cloud_ptr_outliers, pub_outliers);
		 }

	 }
*/
/*
	 PointCloud::Ptr msg_non_filtered (new PointCloud);
	 msg_non_filtered->header.frame_id = "tf_pmd_camcube";
	 msg_non_filtered->height = 1;
	 msg_non_filtered->width = noOfRows*noOfColumns;
	 for  (int i =0; i< noOfRows*noOfColumns ; i++){
		 pcl::PointXYZI temp_point;
		 temp_point.x = cartesianDist[(i*3) + 0];
		 temp_point.y = cartesianDist[(i*3) + 1];
		 temp_point.z = cartesianDist[(i*3) + 2];
		 temp_point.intensity = amplitudes[i];
		 msg_non_filtered->points.push_back(temp_point);
		 //msg_non_filtered->points.push_back ( pcl::PointXYZI(cartesianDist[(i*3) + 0],cartesianDist[(i*3) + 1],cartesianDist[(i*3) + 2], amplitudes[i]) );
	 }
	 msg_non_filtered->header.stamp = ros::Time::now ();
	 pub_non_filtered.publish (msg_non_filtered);
*/

for (int i = 0; i < pmd_data.Distances.size(); i++) {

pmd_data.Distances[i] = distances[i];
if(distances[i]>pmd_img.maxDist) pmd_img.maxDist = distances[i];
//pmd_img.Pixels[i] = map_depth_to_grey(distances[i],pmd_img.maxDist);
pmd_img.Pixels[i] = map_depth_to_grey(distances[i],5);
if(pmd_img.Pixels[i]>pmd_img.maxPixel) pmd_img.maxPixel = pmd_img.Pixels[i];
}
/*
const char *file_o = {"/home/emi/AAA/emi2.bmp"};
CImg<unsigned char> depth_gen_img(pmd_data.Pixels,400,400,1,1,false), color(1);
if (file_o) depth_gen_img.save(file_o);
sleep(2);*/
// pmd_data.Distances[1] = distances[1];
// ROS_INFO("%f",  pmd_data.Distances[1]);
 depth_map.publish (pmd_data);
 depth_img.publish (pmd_img);
	//emi* free memory
	//free(cartesianDist);
	//free(amplitudes);
	

	
	free(distances);

	return 1;
}



int main(int argc, char *argv[]) {

	ros::init (argc, argv, "pmd_camcube_3");
	ros::NodeHandle nh;

	dynamic_reconfigure::Server<pmd_camcube_3_ros_pkg::pmd_camcube_3_ros_pkgConfig> srv;
	dynamic_reconfigure::Server<pmd_camcube_3_ros_pkg::pmd_camcube_3_ros_pkgConfig>::CallbackType f;
	f = boost::bind(&callback, _1, _2);
	srv.setCallback(f);

	if(initialize(argc, argv,nh)){
		printf("Initalized Camera...Now Reading Data :) :) \n");
		ros::Rate loop_rate(10);
		while (nh.ok() && dataPublished)
		{
			if(publishData()) dataPublished==true;
			ros::spinOnce ();
			loop_rate.sleep ();
		}
	} else {
		printf("Cannot Initialize Camera :( Check the parameters and try again!!\n");
	}

	pmdClose (hnd);
	return 0;
}

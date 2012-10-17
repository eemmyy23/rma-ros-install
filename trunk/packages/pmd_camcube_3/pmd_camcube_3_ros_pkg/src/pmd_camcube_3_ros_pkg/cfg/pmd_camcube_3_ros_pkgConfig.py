## *********************************************************
## 
## File autogenerated for the pmd_camcube_3_ros_pkg package 
## by the dynamic_reconfigure package.
## Please do not edit.
## 
## ********************************************************/

##**********************************************************
## Software License Agreement (BSD License)
##
##  Copyright (c) 2008, Willow Garage, Inc.
##  All rights reserved.
##
##  Redistribution and use in source and binary forms, with or without
##  modification, are permitted provided that the following conditions
##  are met:
##
##   * Redistributions of source code must retain the above copyright
##     notice, this list of conditions and the following disclaimer.
##   * Redistributions in binary form must reproduce the above
##     copyright notice, this list of conditions and the following
##     disclaimer in the documentation and/or other materials provided
##     with the distribution.
##   * Neither the name of the Willow Garage nor the names of its
##     contributors may be used to endorse or promote products derived
##     from this software without specific prior written permission.
##
##  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
##  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
##  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
##  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
##  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
##  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
##  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
##  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
##  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
##  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
##  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
##  POSSIBILITY OF SUCH DAMAGE.
##**********************************************************/

config_description = [{'srcline': 17, 'description': 'Integration time(in msec) for the sensor', 'max': 5000, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Integration_Time', 'edit_method': '', 'default': 250, 'level': 0, 'min': 238, 'type': 'int'}, {'srcline': 19, 'description': 'Set the modulation frequency(Hz) of the sensor. By Default the frequency closest to the given value will be set.', 'max': 23000000, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Modulation_Frequency', 'edit_method': '', 'default': 20000000, 'level': 0, 'min': 18000000, 'type': 'int'}, {'srcline': 20, 'description': 'Modulation Frequency no less than the entered frequency will be set', 'max': True, 'cconsttype': 'const bool', 'ctype': 'bool', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'At_Least', 'edit_method': '', 'default': False, 'level': 0, 'min': False, 'type': 'bool'}, {'srcline': 21, 'description': 'Modulation Frequency no more than the entered frequency will be set', 'max': True, 'cconsttype': 'const bool', 'ctype': 'bool', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'At_Most', 'edit_method': '', 'default': False, 'level': 0, 'min': False, 'type': 'bool'}, {'srcline': 23, 'description': 'Whether to apply statistical noise filter from pcl or not.', 'max': True, 'cconsttype': 'const bool', 'ctype': 'bool', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Statistical_Noise_Filter_On', 'edit_method': '', 'default': False, 'level': 0, 'min': False, 'type': 'bool'}, {'srcline': 24, 'description': 'No of neighbours to be considered for applying statistical noise reduction', 'max': 200, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Noise_Filtering_NoOfNeighbours', 'edit_method': '', 'default': 30, 'level': 0, 'min': 1, 'type': 'int'}, {'srcline': 25, 'description': 'Standard Deviation Multiplier Threshold for applying statistical noise reduction', 'max': 10.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Std_Dev_Mul_Threshold', 'edit_method': '', 'default': 0.4, 'level': 0, 'min': 0.0, 'type': 'double'}, {'srcline': 27, 'description': 'Whether to apply amplitude filter or not. Image pixels with amplitude values less than the threshold will be filtered out', 'max': True, 'cconsttype': 'const bool', 'ctype': 'bool', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Amplitude_Filter_On', 'edit_method': '', 'default': False, 'level': 0, 'min': False, 'type': 'bool'}, {'srcline': 28, 'description': 'What should be the amplitude filter threshold. Image pixels with lesser aplitude values will be filtered out. Amplitude Filter Status should be true to use this filter.', 'max': 2500.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '../cfg/pmd_camcube_3.cfg', 'name': 'Amplitude_Threshold', 'edit_method': '', 'default': 0.0, 'level': 0, 'min': 0.0, 'type': 'double'}]

min = {}
max = {}
defaults = {}
level = {}
type = {}
all_level = 0

for param in config_description:
    min[param['name']] = param['min']
    max[param['name']] = param['max']
    defaults[param['name']] = param['default']
    level[param['name']] = param['level']
    type[param['name']] = param['type']
    all_level = all_level | param['level']


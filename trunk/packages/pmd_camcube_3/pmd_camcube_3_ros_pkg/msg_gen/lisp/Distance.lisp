; Auto-generated. Do not edit!


(cl:in-package pmd_camcube_3_ros_pkg-msg)


;//! \htmlinclude Distance.msg.html

(cl:defclass <Distance> (roslisp-msg-protocol:ros-message)
  ((Distances
    :reader Distances
    :initarg :Distances
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass Distance (<Distance>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Distance>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Distance)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pmd_camcube_3_ros_pkg-msg:<Distance> is deprecated: use pmd_camcube_3_ros_pkg-msg:Distance instead.")))

(cl:ensure-generic-function 'Distances-val :lambda-list '(m))
(cl:defmethod Distances-val ((m <Distance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:Distances-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:Distances instead.")
  (Distances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Distance>) ostream)
  "Serializes a message object of type '<Distance>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'Distances))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'Distances))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Distance>) istream)
  "Deserializes a message object of type '<Distance>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'Distances) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'Distances)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Distance>)))
  "Returns string type for a message object of type '<Distance>"
  "pmd_camcube_3_ros_pkg/Distance")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Distance)))
  "Returns string type for a message object of type 'Distance"
  "pmd_camcube_3_ros_pkg/Distance")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Distance>)))
  "Returns md5sum for a message object of type '<Distance>"
  "b7c0d0f9565f53d3ad5c0e99ce58dd26")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Distance)))
  "Returns md5sum for a message object of type 'Distance"
  "b7c0d0f9565f53d3ad5c0e99ce58dd26")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Distance>)))
  "Returns full string definition for message of type '<Distance>"
  (cl:format cl:nil "float32[] Distances~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Distance)))
  "Returns full string definition for message of type 'Distance"
  (cl:format cl:nil "float32[] Distances~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Distance>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'Distances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Distance>))
  "Converts a ROS message object to a list"
  (cl:list 'Distance
    (cl:cons ':Distances (Distances msg))
))

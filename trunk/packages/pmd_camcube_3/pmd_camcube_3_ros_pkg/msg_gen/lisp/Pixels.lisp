; Auto-generated. Do not edit!


(cl:in-package pmd_camcube_3_ros_pkg-msg)


;//! \htmlinclude Pixels.msg.html

(cl:defclass <Pixels> (roslisp-msg-protocol:ros-message)
  ((Pixels
    :reader Pixels
    :initarg :Pixels
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (maxDist
    :reader maxDist
    :initarg :maxDist
    :type cl:float
    :initform 0.0)
   (maxPixel
    :reader maxPixel
    :initarg :maxPixel
    :type cl:fixnum
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:fixnum
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Pixels (<Pixels>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pixels>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pixels)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pmd_camcube_3_ros_pkg-msg:<Pixels> is deprecated: use pmd_camcube_3_ros_pkg-msg:Pixels instead.")))

(cl:ensure-generic-function 'Pixels-val :lambda-list '(m))
(cl:defmethod Pixels-val ((m <Pixels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:Pixels-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:Pixels instead.")
  (Pixels m))

(cl:ensure-generic-function 'maxDist-val :lambda-list '(m))
(cl:defmethod maxDist-val ((m <Pixels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:maxDist-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:maxDist instead.")
  (maxDist m))

(cl:ensure-generic-function 'maxPixel-val :lambda-list '(m))
(cl:defmethod maxPixel-val ((m <Pixels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:maxPixel-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:maxPixel instead.")
  (maxPixel m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <Pixels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:width-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <Pixels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pmd_camcube_3_ros_pkg-msg:height-val is deprecated.  Use pmd_camcube_3_ros_pkg-msg:height instead.")
  (height m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pixels>) ostream)
  "Serializes a message object of type '<Pixels>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'Pixels))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'Pixels))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'maxDist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'maxPixel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pixels>) istream)
  "Deserializes a message object of type '<Pixels>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'Pixels) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'Pixels)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'maxDist) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'maxPixel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pixels>)))
  "Returns string type for a message object of type '<Pixels>"
  "pmd_camcube_3_ros_pkg/Pixels")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pixels)))
  "Returns string type for a message object of type 'Pixels"
  "pmd_camcube_3_ros_pkg/Pixels")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pixels>)))
  "Returns md5sum for a message object of type '<Pixels>"
  "25405a9889a230a21c04df203440f575")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pixels)))
  "Returns md5sum for a message object of type 'Pixels"
  "25405a9889a230a21c04df203440f575")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pixels>)))
  "Returns full string definition for message of type '<Pixels>"
  (cl:format cl:nil "uint8[] Pixels~%float32 maxDist~%uint8 maxPixel~%uint8 width~%uint8 height~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pixels)))
  "Returns full string definition for message of type 'Pixels"
  (cl:format cl:nil "uint8[] Pixels~%float32 maxDist~%uint8 maxPixel~%uint8 width~%uint8 height~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pixels>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'Pixels) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     4
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pixels>))
  "Converts a ROS message object to a list"
  (cl:list 'Pixels
    (cl:cons ':Pixels (Pixels msg))
    (cl:cons ':maxDist (maxDist msg))
    (cl:cons ':maxPixel (maxPixel msg))
    (cl:cons ':width (width msg))
    (cl:cons ':height (height msg))
))

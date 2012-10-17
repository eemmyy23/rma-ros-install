
(cl:in-package :asdf)

(defsystem "pmd_camcube_3_ros_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Pixels" :depends-on ("_package_Pixels"))
    (:file "_package_Pixels" :depends-on ("_package"))
    (:file "Distance" :depends-on ("_package_Distance"))
    (:file "_package_Distance" :depends-on ("_package"))
  ))
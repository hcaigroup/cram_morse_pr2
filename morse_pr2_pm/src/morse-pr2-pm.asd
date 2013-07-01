;; Copyright notice
(in-package :asdf)


(defsystem morse-pr2-pm
  :description "CRAM process modules for PR2 robot in MORSE simulator"
  :version ""
  :author ""
  :licence ""
  :depends-on (process-modules
               designators ;; for reference
               cram-roslisp-common ;; to init process module
               cram-reasoning ;; for prolog with desigs
               cl-tf
               actionlib ;; is actionlib-lisp
               alexandria
               ;; for navig
               move_base_msgs-msg
               geometry_msgs-msg
               
               ;; ;; for ptu
               ;; jido_move_head-msg
               ;; ;; for manipulation
               ;; sensor_msgs-msg

               ;; morse_jido_manipulation_action-msg
               ;; kdl_arm_kinematics-srv
               ;; kinematics_msgs-msg
               ;; kinematics_msgs-srv
               ;; cram-utilities
               )

  :components
  ((:file "package")
   (:file "action-client-util" :depends-on ("package"))
   (:module "navig"
            :depends-on ("package" "action-client-util")
            :components
            ((:file "morse-pr2-nav-action-client" )
             (:file "morse-pr2-navigation-process-module" :depends-on ("morse-pr2-nav-action-client"))))

   ;; Do not exist yet for PR2!
   ;; (:module "ptu"
   ;;          :depends-on ("package" "action-client-util")
   ;;          :components
   ;;          ((:file "morse-jido-ptu-action-client" )
   ;;           (:file "morse-jido-ptu-process-module" :depends-on ("morse-jido-ptu-action-client"))))
   ;; (:module "manip"
   ;;          :depends-on ("package" "action-client-util")
   ;;          :components
   ;;          ((:file "morse-jido-manip-action-client")
   ;;           (:file "designator")
   ;;           (:file "kinematics")
   ;;           (:file "morse-jido-manip-process-module" :depends-on ("designator" "kinematics" "morse-jido-manip-action-client"))))
   ))
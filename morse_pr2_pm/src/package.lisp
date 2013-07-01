(in-package :cl-user)

(cram-designator-properties:def-desig-package morse-pr2-pm
    (:nicknames :mpr2-pm)
  (:use #:common-lisp
        #:cram-reasoning
        #:cram-process-modules
        #:desig
        #:roslisp
        #:cram-utilities
        #:roslisp)
  (:export
   #:morse-pr2-navigation-process-module
   ;; The following are yet to be done
   ;; #:morse-pr2-manip-process-module
   ;; #:morse-pr2-ptu-process-module
   )
  (:desig-properties
   ;; adapto
   #:reach-location
   ;; from designators
   #:obj #:location #:object #:pose #:of #:at #:type #:trajectory
   ;; from cram_plan_library
   #:to #:see #:reach #:open #:side
   #:grasp #:lift #:carry :reach #:at #:parked #:close
   #:gripper #:follow #:pick-up #:put-down #:height #:orientation #:in
   #:obstacle
   ))
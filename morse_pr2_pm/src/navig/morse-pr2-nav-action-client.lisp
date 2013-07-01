(in-package :mpr2-pm)

(alexandria:define-constant +move-base-action-namespace+ "move_base" :test #'string=)
(alexandria:define-constant +move-base-action-type+ "move_base_msgs/MoveBaseAction" :test #'string=)

(defun init-navi-ac ()
  (register-action-client-def +move-base-action-namespace+ +move-base-action-type+)
  ;; initialisation on first time call
  (get-action-client +move-base-action-namespace+))

;; makes sure the above is started when calling cram-roslisp-common:start-ros-node
(cram-roslisp-common:register-ros-init-function init-navi-ac)

(defun make-navigation-action-goal (pose-stamped)
  "expects a tf:pose-stamped and returns an action goal message"
  (actionlib:make-action-goal
   (get-action-client +move-base-action-namespace+)
   target_pose (cl-tf:pose-stamped->msg pose-stamped)))

;;start a ros node before
(defun call-navigation-action (pose-stamped)
  (multiple-value-bind (result status)
      (let ((actionlib:*action-server-timeout* 10.0))
        (actionlib:call-goal
         (get-action-client +move-base-action-namespace+)
         (make-navigation-action-goal pose-stamped)))
    (roslisp:ros-info (nav-goal-action-client) "Nav action finished.")
    (values result status)))
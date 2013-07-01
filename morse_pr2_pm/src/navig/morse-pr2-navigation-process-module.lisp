(in-package :mpr2-pm)

(defun run-nav-action (desig)
  "dereferences the goal designator and calls the action client"
  (let ((pose-stamped (reference desig)))
    (call-navigation-action pose-stamped)
    ;; (multiple-value-bind (result status)
    ;;   (declare (ignore result status))
    ;;   (mjido-nav-ac:call-navigation-action pose-stamped)
    ;;   (roslisp:ros-info (pr2-nav process-module) "Nav action finished.")
      ;; (unless (and ;; (eq status :succeeded)
      ;;              (goal-reached? (reference desig)))
      ;;   (cpl-impl:fail 'location-not-reached-failure
      ;;                  :location (reference desig)))
      ))

(def-process-module morse-pr2-navigation-process-module (goal)
  (unwind-protect
       ;; (cpl-impl:pursue
         (progn
           (ros-info (mpr2-nav-pm process-module)
                             "Morse nav pm called.")
           (run-nav-action goal)
           (ros-info (mpr2-nav-pm process-module) "Navigation finished."))
         ;; )
    ))

;; build coordinate loc desig e.g. with:
;; (with-designators
;;                   (( my-desig
;;                      (location `((pose
;;                                  ,(tf:make-pose-stamped "/map" 0.0
;;                                    (tf:make-3d-vector 1.0 -1.0 0.0)
;;                                    (tf:euler->quaternion :az (/ pi 2.0))))))))
;;              (reference my-desig))
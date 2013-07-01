(in-package :mpr2-pm)

(defstruct action-client
  namespace
  actiontype
  instance)

(defvar *actionclients* (make-hash-table :test 'equal))

(defun register-action-client-def (namespace action-type)
  "registers the name and action type of an action server for client creation"
  ;; TODO check duplicate
  (let ((client-def (make-action-client :namespace namespace :actiontype action-type)))
    (setf (gethash namespace *actionclients*) client-def))
  T)

;;initiate the action client
(defun init-action-client (client-def)
  (let ((simple-action-client (actionlib:make-action-client
                                  (action-client-namespace client-def)
                                  (action-client-actiontype client-def))))

    (ros-info (action-client-util)
              "Waiting for action server node with namespace ~a ..." (action-client-namespace client-def))
  ;; workaround for race condition in actionlib wait-for server
    (loop until
          (actionlib:wait-for-server simple-action-client 5)
          do (ros-info (action-client-util)
              "Still waiting for namespace ~a." (action-client-namespace client-def)))
    (ros-info (action-client-util)
              "Action client to ~a created." (action-client-namespace client-def))
    (setf (action-client-instance client-def) simple-action-client)))


(defun get-action-client (namespace)
  (let ((client-def (gethash namespace *actionclients*)))
    (when (null client-def)
      (error "No action client defined for node name ~a~%" namespace))
    (when (null (action-client-instance client-def))
      (init-action-client client-def))
    (action-client-instance client-def)))
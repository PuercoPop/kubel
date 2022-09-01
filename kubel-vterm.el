;;; kubel-vterm.el --- vterm integration with kubel -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'kubel)
(require 'vterm)
(require 'transient)

(defun kubel-exec-vterm-pod ()
  "Exec into the pod under the cursor -> vterm."
  (interactive)
  (kubel-setup-tramp)
  (let* ((dir-prefix (kubel--dir-prefix))
         (con-pod (kubel--get-container-under-cursor))
         (container (car con-pod))
         (pod (cdr con-pod))
         (default-directory (format "/%skubectl:%s@%s:/" dir-prefix container pod))
         (vterm-buffer-name (format "*kubel - vterm - %s@%s*" container pod))
         (vterm-shell "/bin/sh"))
    (vterm)))

;;;###autoload
(defun kubel-vterm-setup ()
  "Adds a vterm enty to the KUBEL-EXEC-POP."
  (transient-append-suffix 'kubel-exec-popup "e"
    '("v" "Vterm" kubel-exec-vterm-pod)))

(provide 'kubel-vterm)
;;; kubel-vterm.el ends here

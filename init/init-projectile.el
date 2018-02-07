;;; init-projectile.el --- Project-wide navigation and functions

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (progn
    (setq projectile-enable-caching is-windows
          projectile-indexing-method 'alien)
    (add-to-list 'projectile-globally-ignored-files ".DS_Store")
    (add-to-list 'projectile-globally-ignored-directories "node_modules")
    (add-to-list 'projectile-globally-ignored-directories "bower_components")
    (projectile-register-project-type
     'node '("package.json")
     :test "npm test"
     :test-suffix "-test.js")
    (projectile-global-mode)))

(use-package counsel-projectile
  :ensure t
  :after (counsel projectile)
  :config
  (counsel-projectile-on))

(provide 'init-projectile)

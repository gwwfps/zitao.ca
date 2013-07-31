(ns zitao.ca.main
  (:require
    [express]
    [jade]))

(def app (express))

(defmacro from-base [path]
  `(+ __dirname "/../" ~path))

(do
  (app.configure
    (fn []
      (app.set :views (from-base "views"))
      (app.engine :jade (.-__express jade))
      (app.set "view engine" :jade)
      (app.use "/css" (express.static (from-base "css")))
      nil))

  (app.get "/"
    (fn [req, res]
      (res.render "main.jade")))
  
  (app.listen 3000)  
  (console.log "Started application"))


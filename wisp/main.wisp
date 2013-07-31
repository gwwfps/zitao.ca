(ns zitao.ca.main
  (:require
    [express]
    [jade]))

(def app (express))

(do
  (app.configure
    (fn []
      (app.set :views (+ __dirname "/../views"))
      (app.engine :jade (.-__express jade))
      (app.set "view engine" :jade)
      nil))

  (app.get "/"
    (fn [req, res]
      (res.render "main.jade")))
  
  (app.listen 3000)  
  (console.log "Started application"))


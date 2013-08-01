(ns zitao.ca.main
  (:require
    [express]
    [jade]
    [zitao.ca.blog :as blog]
    [zitao.ca.locals :as locals]))

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

  (app.locals locals.properties)

  (app.get "/" (.-index blog))
  
  (app.listen 3000)  
  (console.log "Started application"))


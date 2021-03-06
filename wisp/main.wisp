(ns zitao.ca.main
  (:require
    [express]
    [jade]
    [zitao.ca.blog :as blog]
    [zitao.ca.pages :as pages]
    [zitao.ca.locals :as locals]
    [zitao.ca.config :refer [settings]]))

(def app (express))

(defmacro from-base [path]
  `(+ __dirname "/../" ~path))

(defn- route
  [& routes]
  (.map routes
    (fn [params]
      (apply
        (fn
          ([method path handler] (
            (get app method) path handler))
          ([path handler] (
            app.get path handler)))
        params))))

(do
  (app.configure
    (fn []
      (app.set :views (from-base "views"))
      (app.engine :jade (.-__express jade))
      (app.set "view engine" :jade)
      (app.use "/css" (express.static (from-base "css")))
      nil))

  (app.locals locals.properties)

  (route 
    ["/" blog.index]
    ["/post/:id" blog.post]
    ["/page/:id" pages.page])
  
  (app.listen (:app-port settings) (:app-host settings))  
  (console.log "Started application"))

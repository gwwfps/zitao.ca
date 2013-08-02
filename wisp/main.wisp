(ns zitao.ca.main
  (:require
    [express]
    [jade]
    [zitao.ca.blog :as blog]
    [zitao.ca.pages :as pages]
    [zitao.ca.locals :as locals]))

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

(defn start [config]
  (do
    (app.configure
      (fn []
        (app.set :views (from-base "views"))
        (app.engine :jade (.-__express jade))
        (app.set "view engine" :jade)
        (app.use "/css" (express.static (from-base "css")))
        nil))

    (app.locals locals.properties)
    (app.locals {:config config})

    (route 
      ["/" blog.index]
      ["/post/:id" blog.post]
      ["/page/:id" pages.page])
    
    (app.listen 3000)  
    (console.log "Started application")))

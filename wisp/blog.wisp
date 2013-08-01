(ns zitao.ca.blog)

(def posts [
    {:title "Abc Defg 1" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    {:title "Abc Defg2" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    ])

(defn index [req res]
  (res.render "main.jade" {:posts posts}))


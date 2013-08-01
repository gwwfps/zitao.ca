(ns zitao.ca.blog
  (:require
    [wisp.sequence :refer [first]]))

(def posts [
    {:id "article-1" :title "Abc Defg 1" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    {:id "article-2" :title "Abc Defg2" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    ])

(defn index [req res]
  (res.render "main.jade" {:posts posts}))

(defn post [req res]
  (res.render "post.jade" {:post (first posts)}))


(ns zitao.ca.blog
  (:require
    [moment]
    [markdown :refer [markdown]]
    [lodash :refer [assign clone-deep]]))

(def posts [
    {:title "Abc Defg 1" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    {:title "Abc Defg2" :content " __Getting Started__
This plugin requires Grunt `~0.4.1`" :timestamp 13213567}
    ])

(defn format-post [post]
  (let [
    processed (clone-deep post)
    post-moment (moment post.timestamp)]
    (assign processed {
      :content (markdown.toHTML post.content)
      :time (post-moment.from-now)
      :iso (post-moment.format "YYYY-MM-DD HH:mm")})))

(defn index [req res]
  (res.render "main.jade" {:posts (.map posts format-post)}))


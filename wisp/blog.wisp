(ns zitao.ca.blog
  (:require
    [markdown :refer [markdown]]
    [lodash :refer [assign clone-deep]]))

(def posts [
    {:title "abcdefg" :content "654321"}
    {:title "abcdefg" :content "654321"}
    ])

(defn markdown-content [post]
  (let [processed (clone-deep post)]
    (assign processed {:content (markdown.toHTML post.content)})))

(defn index [req res]
  (res.render "main.jade" {:posts (posts.map markdown-content)}))


(ns zitao.ca.blog
  (:require    
    [zitao.ca.storage :as storage]
    [zitao.ca.utils :refer [render]]))

(defn index [req res]
  (render res (storage.posts) "main.jade" :posts))

(defn post [req res]
  (render res (storage.query-doc req.params.id) "post.jade" :post))

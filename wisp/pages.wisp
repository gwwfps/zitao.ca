(ns zitao.ca.pages
  (:require
    [zitao.ca.storage :as storage]
    [zitao.ca.utils :refer [render]]))

(defn page [req res]
  (render res (storage.query-doc req.params.id) "page.jade" :page))
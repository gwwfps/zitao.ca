(ns zitao.ca.storage
  (:require
    [request]
    [q]
    [lodash :refer [pluck]]
    [zitao.ca.config :refer [settings]]))

(defn query-view [view-name options]
  (let [deferred (.defer q)]
    (do 
      (request.get 
        (+ (:couch-url settings) "/"
          (:couch-design-doc-id settings) "/_view/"
          view-name)
        (fn [e r body]
          (if e
            (deferred.reject (Error. e))
            (deferred.resolve (JSON.parse body)))))
      (:promise deferred))))

(defn posts
  ([] (posts 1))
  ([page]
    (.then (query-view :posts)
      (fn [data]
        (pluck (:rows data) :value)))))
(ns zitao.ca.storage
  (:require
    [wisp.sequence :refer [reduce]]
    [request]    
    [lodash :refer [pluck]]
    [zitao.ca.config :refer [settings]]
    [zitao.ca.utils :refer [with-promise]]))


(defn couch-url [& segments]
  (reduce
    (fn [path segment]
      (+ path "/" segment))    
    (:couch-url settings)
    segments))

(defn- res-to-json [deferred]
  (fn [e r body]
    (if e
      (deferred.reject (Error. e))
      (let [parsed (JSON.parse body)]
        (if (:error parsed)
          (deferred.reject parsed)
          (deferred.resolve parsed))))))

(defn query-view [view-name options]
  (with-promise
    (fn [deferred]
      (request.get
        { :url (couch-url (:couch-design-doc-id settings) "_view" view-name)
          :qs options}
        (res-to-json deferred)))))

(defn query-doc [id]
  (with-promise
    (fn [deferred]
      (request.get (couch-url id) (res-to-json deferred)))))

(defn posts
  ([] (posts 1))
  ([page]
    (.then (query-view :posts {:descending true :limit 10})
      (fn [data]
        (pluck (:rows data) :value)))))
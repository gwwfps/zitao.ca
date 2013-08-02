(ns zitao.ca.utils
  (:require 
    [q]
    [lodash :refer [zip-object]]))

(defn with-promise [f]
  (let [deferred (.defer q)]
    (do
      (f deferred)
      (:promise deferred))))

(defn render [res promise view var-name]
  (.then promise
    (fn [obj]      
      (.render res view (zip-object [var-name] [obj])))
    (fn [error]
      (if (identical? :not_found error.error)
        (.send res 404 "Page not found.")
        (.send res 500 "Error.")))))

(ns zitao.ca.locals
  (:require
    [marked]
    [moment]))

(def properties {
  :markdown marked
  :ago (fn [timestamp] (.from-now (moment timestamp)))
  :iso (fn [timestamp] (.format (moment timestamp) "YYYY-MM-DD HH:mm"))
  })
(ns zitao.ca.config
  (:require [fs]))

(def settings 
  (JSON.parse (fs.readFileSync (+ __dirname "/../config.json"))))

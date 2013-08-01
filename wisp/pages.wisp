(ns zitao.ca.pages)

(defn page [req res]
  (res.render "page.jade" {:page {:content "something something" :title "About me"}}))
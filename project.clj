(defproject lazer "0.1.0-SNAPSHOT"
  :description "The best templating language ever!"
  :dependencies [[org.clojure/clojure "1.4.0"]]
  :dev-dependencies [[lein-antlr "0.1.0"]]

  :antlr-src-dir "src/main/antlr"
  :antlr-dest-dir "src/main/java/generated"
  :antlr-options {:verbose true})
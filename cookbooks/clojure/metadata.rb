name              "clojure"
maintainer        "Jonathan Badger"
maintainer_email  "jhbadger@gmail.com"
license           "Apache 2.0"
description       "Installs leiningen clojure framework"
version           "0.0.1"
recipe            "clojure", "Installs leiningen"

%w{ build-essential mercurial }.each do |cookbook|
  depends cookbook
end
name              "chibi-scheme"
maintainer        "Xavier Lange"
maintainer_email  "xrlange@gmail.com"
license           "Apache 2.0"
description       "Installs chibi-scheme"
# long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "chibi-scheme", "Installs chibi-scheme"

%w{ build-essential mercurial }.each do |cookbook|
  depends cookbook
end
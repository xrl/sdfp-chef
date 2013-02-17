maintainer       "Xavier Lange"
maintainer_email "xrlange@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures zeromq3 library"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w( build-essential ).each{|cookbook| depends cookbook }
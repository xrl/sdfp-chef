#
# Cookbook Name:: zeromq
# Recipe:: default
#
# Author:: Xavier Lange (<xrlange@gmail.com>)
#
# Copyright 2013, Xavier Lange
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "libtool"

zmq_source_dir = "/usr/local/src/zeromq"

git zmq_source_dir do
  repository "git://github.com/zeromq/zeromq3-x.git"
  revision   "v3.2.2"
  action :sync
end

execute "build and install libzmq" do
  cwd zmq_source_dir
  creates "/usr/local/lib/libzmq.so"
  command <<-SH
    ./autogen.sh
    ./configure
    make
    make install
    ldconfig
  SH
end
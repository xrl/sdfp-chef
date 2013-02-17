#
# Cookbook Name:: mongrel2
# Recipe:: default
#
# Author:: Thomas Rampelberg (<thomas@saunter.org>)
#
# Copyright 2011, Thomas Rampelberg
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

%w{ sqlite3 libsqlite3-dev }.each do |pkg|
  package pkg do
    action :upgrade
  end
end

user node[:mongrel2][:user] do
  comment "Mongrel2 Administrator"
  system true
  shell "/bin/bash"
end

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


source_dir = "/usr/local/src/mongrel2"

git source_dir do
  repository node[:mongrel2][:source][:git][:url]
  revision   node[:mongrel2][:source][:git][:branch]
  action :sync
end

execute "build and install mongrel2" do
  cwd source_dir
  creates `which m2sh`.chomp
  command <<-SH
    make
    PREFIX=#{node[:mongrel2][:prefix]} make install
  SH
end

basedir = node[:mongrel2][:chroot]
m2_user = node[:mongrel2][:user]

%w{ etc run logs tmp www }.each do |dir|
  directory "#{basedir}/#{dir}" do
    recursive true
    owner m2_user
    group m2_user
    mode "0755"
  end
end

template "#{basedir}/etc/mongrel2.conf" do
  source "m2.conf.erb"
  user   m2_user
  group  m2_user
end

cookbook_file "#{basedir}/www/index.html" do
  source "index.html"
  mode "0755"
end

bash "generate config <mongrel2-#{node[:mongrel2][:src_version]}" do
  cwd basedir
  code <<-EOH
    m2sh load --db etc/mongrel2.sqlite --config etc/mongrel2.conf
  EOH
end

file "#{basedir}/etc/mongrel2.sqlite" do
  user  m2_user
  group m2_user
end

case node['platform']
when "ubuntu"
  template "/etc/init.d/mongrel2" do
    source "mongrel2.init.erb"
    user   "root"
    group  "root"
    mode   00755
    variables(
      :m2sh => node[:mongrel2][:prefix] + "/bin/mongrel2",
      :pid  => node[:mongrel2][:chroot] + "/run/mongrel2.pid",
      :db   => node[:mongrel2][:chroot] + "/etc/mongrel2.sqlite",
      :uuid => node[:mongrel2][:uuid]
    )
  end
end

# directory "/etc/sv/mongrel2" do
#   recursive true
#   owner "root"
#   group "root"
#   mode 0755
# end

# daemontools_service "mongrel2" do
#   directory "/etc/sv/mongrel2"
#   template "mongrel2"
#   action [:enable,:start]
#   log true
# end

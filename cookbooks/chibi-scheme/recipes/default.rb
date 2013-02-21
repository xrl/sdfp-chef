#
# Cookbook Name:: chibi-scheme
# Recipe:: default
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

chibi_src = "/usr/local/src/chibi-scheme"

mercurial chibi_src do
  repository "https://code.google.com/p/chibi-scheme"
  reference "0.6.1"
  action :sync
end

execute "make chibi-scheme" do
  command "make && make test"
  cwd chibi_src
end

execute "install chibi-scheme" do
  command "PREFIX=/usr/local make install"
  cwd chibi_src
end
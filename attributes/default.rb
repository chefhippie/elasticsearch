#
# Cookbook Name:: elasticsearch
# Attributes:: default
#
# Copyright 2013, Thomas Boerger
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

default["elasticsearch"]["version"] = "0.90.7"

case node["platform_family"]
when "debian"
  default["elasticsearch"]["download_file"] = "elasticsearch-#{node["elasticsearch"]["version"]}.deb"
  default["elasticsearch"]["download_url"] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{node["elasticsearch"]["download_file"]}"
  default["elasticsearch"]["sysconfig_file"] = "/etc/default/elasticsearch"
when "ubuntu"
  default["elasticsearch"]["download_file"] = "elasticsearch-#{node["elasticsearch"]["version"]}.deb"
  default["elasticsearch"]["download_url"] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{node["elasticsearch"]["download_file"]}"
  default["elasticsearch"]["sysconfig_file"] = "/etc/default/elasticsearch"
when "suse"
  default["elasticsearch"]["download_file"] = "elasticsearch-#{node["elasticsearch"]["version"]}.noarch.rpm"
  default["elasticsearch"]["download_url"] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{node["elasticsearch"]["download_file"]}"
  default["elasticsearch"]["sysconfig_file"] = "/etc/sysconfig/elasticsearch"
end

default["elasticsearch"]["service_name"] = "elasticsearch"
default["elasticsearch"]["config_file"] = "/etc/elasticsearch/elasticsearch.yml"
default["elasticsearch"]["logging_file"] = "/etc/elasticsearch/logging.yml"
default["elasticsearch"]["listen"] = "127.0.0.1"
default["elasticsearch"]["port"] = 9200
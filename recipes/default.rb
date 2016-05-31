#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

include_recipe "java"

remote_file ::File.join(Chef::Config[:file_cache_path], node["elasticsearch"]["package_file"]) do
  source node["elasticsearch"]["package_url"]

  owner "root"
  group "root"
  mode "0444"
  action :create_if_missing
end

case node["platform_family"]
when "debian"
  dpkg_package ::File.join(Chef::Config[:file_cache_path], node["elasticsearch"]["package_file"]) do
    action :install
  end
when "suse"
  rpm_package ::File.join(Chef::Config[:file_cache_path], node["elasticsearch"]["package_file"]) do
    action :install
  end
end

template node["elasticsearch"]["sysconfig_file"] do
  source "sysconfig.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["elasticsearch"]
  )

  notifies :restart, "service[elasticsearch]"

  not_if do
    node["elasticsearch"]["sysconfig_file"].empty?
  end
end

template node["elasticsearch"]["config_file"] do
  source "elasticsearch.yml.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["elasticsearch"]
  )

  notifies :restart, "service[elasticsearch]"

  not_if do
    node["elasticsearch"]["config_file"].empty?
  end
end

template node["elasticsearch"]["logging_file"] do
  source "logging.yml.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["elasticsearch"]
  )

  notifies :restart, "service[elasticsearch]"
end

service "elasticsearch" do
  service_name node["elasticsearch"]["service_name"]
  action [:enable, :start]
end

#
# Cookbook Name:: fw1
# Recipe:: default
#
# Copyright 2012, Courtney Wilburn
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
# Create Directory if missing

directory "#{node['fw1']['install_path']}" do
 owner "vagrant"
 group "vagrant"
 mode "0755"
 action :create
 not_if { File.directory?("#{node['fw1']['install_path']}") }
end

# Checkout Framework One Repo
git "#{node['cf10']['frameworks']}/fw1" do                            
  repository "#{node['fw1']['git']['repository']}"
  revision "#{node['fw1']['git']['revision']}"                                  
  action :sync                                     
  ssh_wrapper "#{Chef::Config['file_cache_path']}/wrap-ssh4git.sh"      	               
end

# Set up ColdFusion mapping

execute "start_cf_for_fw1_default_cf_config" do
  command "/bin/true"
  notifies :start, "service[coldfusion]", :immediately
end

coldfusion10_config "extensions" do
  action :set
  property "mapping"
  args ({ "mapName" => "/fw1",
          "mapPath" => "#{node['fw1']['install_path']}/fw1"})
end
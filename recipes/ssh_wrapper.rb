#
# Cookbook Name:: chef-cfselenium
# Recipe:: ssh_wrapper
#
# Copyright 2012, Nathan Mische
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

# Set up SSH wrapper

directory "#{Chef::Config['file_cache_path']}/.ssh" do
  owner "vagrant"
  mode "0700"
  action :create
end

#deployment_key_item = data_bag_item()

template "#{Chef::Config['file_cache_path']}/.ssh/id_deploy" do
  owner "vagrant"
  mode 0700
  source "id_deploy.erb"
  variables(
    :deployment_key => deployment_key_item["deployment_key"]
  )
end

directory "#{Chef::Config['file_cache_path']}/.ssh" do
  owner "vagrant"
  recursive true
end

template "#{Chef::Config['file_cache_path']}/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh.erb"
  owner "vagrant"
  mode 0700
end

#
# Cookbook Name:: hopsfindbench-chef
# Recipe:: default
#
# Copyright 2015, Hops.io
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
require 'json'
require 'base64'


node.override = {
  'java' => {
    'install_flavor' => 'oracle',
    'jdk_version' => 7,
    'oracle' => {
      'accept_oracle_download_terms' => true
    }
  }
}


private_ip=my_private_ip()

tables_path = "#{Chef::Config[:file_cache_path]}/tables.sql"

hopsfindbench_grants "creds" do
  tables_path  "#{tables_path}"
  action :nothing
end 

 Chef::Log.info("Could not find previously defined #{tables_path} resource")
 template tables_path do
    source File.basename("#{tables_path}") + ".erb"
    owner node[:hopsfindbench][:user]
    mode 0750
    action :create
    variables({
                :private_ip => private_ip
              })
    notifies :create_tables, 'hopsfindbench_grants[creds]', :immediately
  end 

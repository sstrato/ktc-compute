#
# Cookbook Name:: nova
# Recipe:: nova-rsyslog
#
# Copyright 2012, Rackspace US, Inc.
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

file "/etc/rsyslog.d/21-nova.conf" do
  action :delete
end

template "/etc/rsyslog.d/92-nova.conf" do
  source "92-nova.conf.erb"
  owner "nova"
  group "nova"
  mode "0600"
  variables(
    "use_syslog" => node["nova"]["syslog"]["use"],
    "log_facility" => node["nova"]["syslog"]["config_facility"]
  )
  only_if { node["nova"]["syslog"]["use"] == true }
  notifies :restart, "service[rsyslog]", :immediately
end
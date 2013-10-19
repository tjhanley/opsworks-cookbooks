#
# Cookbook Name:: fail2ban
# Recipe:: default
#
# Copyright 2009-2011, Opscode, Inc.
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

# epel repository is needed for the fail2ban package on rhel
if platform_family?("rhel")
  include_recipe "yum::epel"
end

package "fail2ban" do
  action :upgrade
end

%w{ fail2ban jail }.each do |cfg|
  template "/etc/fail2ban/#{cfg}.conf" do
    source "#{cfg}.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, "service[fail2ban]"
    variables(
      :auth_log => node['platform_family'] == 'rhel' ? "secure" : 'auth.log'
    )
  end
end

service "fail2ban" do
  supports [ :status => true, :restart => true ]
  action [ :enable, :start ]

  if (platform?("ubuntu") && node["platform_version"].to_f < 12.04) ||
     (platform?("debian") && node["platform_version"].to_f < 7)
      # status command returns non-0 value only since fail2ban 0.8.6-3 (Debian)
      status_command '/etc/init.d/fail2ban status | grep -q "is running"'
  end
end

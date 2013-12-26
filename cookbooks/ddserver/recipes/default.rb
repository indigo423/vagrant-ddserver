#
# Author:: Ronny Trommer (ronny@opennms.org)
# Cookbook Name:: ddserver
# Recipe:: default
#
# Copyright 2010-2013, Ronny Trommer
#
# Licensed under the GNU GENERAL PUBLIC LICENSE, Version 3.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.gnu.org/licenses/gpl-3.0.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#cd /etc/ddserver/
#cp ddserver.conf.example ddserver.conf
#cd /usr/share/doc/ddserver/
#mysql -u root -p
#mysql -u root -p ddserver < schema.sql
#mysql -u root -p ddserver
#cd /etc/ddserver/

# Platform dependend install from OpenNMS repository
if platform?("redhat", "centos")
	execute "install mysql database server and libraries" do
		command "yum install -y mysql-server mysql-devel python-devel"
		action :run
	end

	service "mysqld" do
		supports :status => true, :restart => true, :reload => true
		action [ :enable, :start]
	end

    bash "clone git repository" do
    	cwd "/usr/local/src"
    	user "root"
    	code <<-EOH
    		git clone https://github.com/reissmann/ddserver.git
    	EOH
    end

    bash "compile and install ddserver" do
    	cwd "/usr/local/src/ddserver"
    	user "root"
    	code <<-EOH
    		python2.7 setup.py install
    	EOH
    end

	bash "set mysql root password" do
	  cwd "/root"
      user "root"
      code <<-EOH
        /usr/bin/mysqladmin -u root password 'secret' && \
        /usr/bin/mmysql -u root --password=secret -e "create database ddserver;" && \
        /usr/bin/mysql -u root --password=secret < /usr/share/doc/ddserver/schema.sql
      EOH
    end
 end
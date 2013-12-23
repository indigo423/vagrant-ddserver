maintainer       "Ronny Trommer"
maintainer_email "ronny@opennms.org"
license          "GPLv3+"
description      "Installs/Configures ddserver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
name             "ddserver"
provides         "ddserver"

recipe "ddserver", "Installs ddserver based on the default installation method"

%w{ centos }.each do |os|
    supports os
end

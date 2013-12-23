name              "python"
maintainer        "Ronny Trommer"
maintainer_email  "ronny@opennms.org"
license           "GPL v3"
description       "Installs Pythong 2.7 on CentOS"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

recipe "python", "Installs Python 2.7"

%w{ redhat centos }.each do |os|
  supports os
end

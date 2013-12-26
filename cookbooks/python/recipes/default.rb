
# Platform dependend install from OpenNMS repository
if platform?("redhat", "centos")

  # Install development environment
  execute "Install development environment" do
    command "yum groupinstall -y development"
    action :run
  end

  execute "Install development libraries" do
    command "yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel xz-libs"
    action :run
  end

  bash "Download and compile Python" do
    cwd "/usr/local/src"
    user "root"
    not_if {::File.exists?("Python-#{node['python']['version']}.tar.xz")}
    code <<-EOH
      wget #{node['python']['url']}/#{node['python']['version']}/Python-#{node['python']['version']}.tar.xz && \
      xz -d Python-#{node['python']['version']}.tar.xz && \
      tar -xvf Python-#{node['python']['version']}.tar && \
      cd Python-#{node['python']['version']} && \
      ./configure --prefix=/usr/local && \
      make && \
      make altinstall && \
      echo "export PATH="/usr/local/bin:$PATH"" >> /root/.bashrc && \
      echo "export PATH="/usr/local/bin:$PATH"" >> /etc/skel/.bashrc && \
      source /root/.bashrc
    EOH
  end

  bash "Install Python setuptools and pip" do
    cwd "/usr/local/src"
    user "root"
    not_if {::File.exists?("setuptools-#{node['setuptool']['version']}.tar.gz")}
    code <<-EOH
      wget --no-check-certificate #{node['setuptool']['url']}/setuptools-#{node['setuptool']['version']}.tar.gz && \
      tar -xvf setuptools-#{node['setuptool']['version']}.tar.gz && \
      cd setuptools-#{node['setuptool']['version']} && \
      python2.7 setup.py install && \
      curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python2.7 - && \
      easy_install-2.7 -U distribute
    EOH
  end
end

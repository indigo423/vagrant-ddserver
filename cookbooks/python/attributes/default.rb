case platform
  when "redhat", "centos", "scientific"
    default[:python][:version] = '2.7.6'
    default[:python][:path] = '/usr/local'
    default[:python][:url] = 'http://www.python.org/ftp/python'
    default[:setuptool][:version] = '1.4.2'
    default[:setuptool][:url] = 'https://pypi.python.org/packages/source/s/setuptools'
end

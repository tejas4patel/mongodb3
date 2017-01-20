#
# Cookbook Name:: mongodb3
# Recipe:: package_repo

# Add the MongoDB 3.0 Package repository
case node['platform_family']
  when 'rhel', 'fedora'
    yum_repository 'mongodb-org-3.0' do
      description 'MongoDB Repository'
      baseurl node['mongodb3']['package']['repo']['url']
      action :create
      gpgcheck false
      enabled true
      sslverify false
    end
  when 'debian'
    apt_repository 'mongodb' do
      uri node['mongodb3']['package']['repo']['url']
      distribution "#{node['lsb']['codename']}/mongodb-org/stable"
      components node['mongodb3']['package']['repo']['apt']['components']
      keyserver node['mongodb3']['package']['repo']['apt']['keyserver']
      key node['mongodb3']['package']['repo']['apt']['key']
      action :add
    end
    include_recipe 'apt'
end

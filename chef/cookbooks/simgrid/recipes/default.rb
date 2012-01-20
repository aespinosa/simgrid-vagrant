#
# Author:: Allam Espinosa <aespinosa@cs.uchicago.edu>
# Cookbook Name:: simgrid
# Recipe:: default
#
require_recipe "build-essential"

package "libpcre3-dev"
package "cmake"

version = node['simgrid']['src_version']
tarball = "#{Chef::Config[:file_cache_path]}/simgrid-#{version}.tar.gz"

remote_file tarball do
  source node['simgrid']['src_mirror']
  not_if { ::FileTest.exists?(tarball) }
end

bash "install simgrid #{node['simgrid']['src_version']} "do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar -xvzf #{tarball}
    cd simgrid-#{node['simgrid']['src_version']}
    cmake .
    make
    make install
  EOF
end

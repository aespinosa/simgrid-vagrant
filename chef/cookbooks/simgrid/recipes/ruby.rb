
#
# Author:: Allam Espinosa <aespinosa@cs.uchicago.edu>
# Cookbook Name:: simgrid
# Recipe:: ruby
#
require_recipe "simgrid"
require_recipe "rvm::ruby_#{node['simgrid::ruby']['rvm_version']}"

version = node['simgrid::ruby']['src_version']
tarball = "#{Chef::Config[:file_cache_path]}/SimGrid-Ruby-#{version}.tar.gz"

cookbook_file "#{Chef::Config[:file_cache_path]}/SimGrid-Ruby.patch"

remote_file tarball do
  source node['simgrid::ruby']['src_mirror']
  not_if { ::FileTest.exists?(tarball) }
end

bash "install SimGrid-Ruby" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar -xvzf #{tarball}
    cd SimGrid-Ruby-#{version}
    patch -p1 < ../SimGrid-Ruby.patch
    source /usr/local/rvm/scripts/rvm
    rvm use default
    cmake .
    make 
    make install
  EOF
end

cookbook_file "/etc/profile.d/simgrid-ruby.sh" do
  mode "0755" 
end

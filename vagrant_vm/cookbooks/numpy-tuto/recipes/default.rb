#
# Cookbook Name:: epd-dependencies
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
case node[:platform_family]
when "debian"
  apt_package "remove_python3" do
    package_name "python3"
    action :purge
  end
  package "gdb"
  package "gfortran"
  package "git"
  package "kcachegrind"
  package "linux-tools"
  package "python-dev"
  package "python-virtualenv"
  package "python2.7-dbg"
  package "valgrind"
end

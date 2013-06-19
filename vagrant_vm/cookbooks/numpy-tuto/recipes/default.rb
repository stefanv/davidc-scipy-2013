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
  package "gfortran"
  package "python-dev"
  package "git"
  package "valgrind"
  package "kcachegrind"
  package "gdb"
  package "python2.7-dbg"
  package "python-virtualenv"
end

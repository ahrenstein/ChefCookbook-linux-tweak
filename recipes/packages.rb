#
# Cookbook Name:: linux-tweak
# Recipe:: packages
#
# Copyright (c) 2015 Ahrenstein, All Rights Reserved.

# This recipe will remove all the Landscape garbage that Canonical thought we would want on our servers.
# It will also make sure vim is present since I set that as the default editor

# Let's only try to purge Landscape from Ubuntu
case node['platform']
  when 'ubuntu'
    # This creates an array of strings and performs the Chef package functionality of each array entry via a do loop
    %w{'landscape-client-ui', 'landscape-client-ui-install', 'landscape-client', 'landscape-common'}.each do |pkg|
      package pkg do
        action :purge
      end
    end
  else
    # Do nothing
end

# This if block checks if the OS is rhel based and sets the rhel vim package name if it is. (Returns as "redhat" in Serverspec code)
case node['platform_family']
  when 'rhel'
    vim_package = 'vim-enhanced'
  # If not we assume the OS is Debian based
  else
    vim_package = 'vim'
end

# Make sure vim is present
case node['os']
  when 'linux'
    package "#{vim_package}" do
      action :install
    end

    # Make sure curl is installed
    package 'curl' do
      action :install
    end
  else
    # Do nothing
end

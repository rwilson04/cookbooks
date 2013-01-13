#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "sudo"
#include_recipe "users"
include_recipe "users::sysadmins"
include_recipe "users::developers"
include_recipe "openssh"

#
# Author:: Derek Groh (<dgroh@arch.tamu.edu>)
# Cookbook Name:: windows_print
# Provider:: printer_settings
#
# Copyright 2013, Texas A&M
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

action :restore do
  execute "Map Network Drive" do
    command "net use z: \"#{new_resource.path}\" /user:\"#{new_resource.domain_username}\" \"#{new_resource.domain_password}\""
  end
  
  execute "new_resource.printer_name" do
    command "RUNDLL32 PRINTUI.DLL,PrintUIEntry /Sr /n \"#{new_resource.printer_name}\" /a \"#{new_resource.path}\\#{new_resource.file}\" d u g 8 r"
  end
  
  execute "Unmap Network Drive" do
    command "net use z: /d"
  end
end

action :create do
  execute "Map Network Drive" do
    command "net use z: \"#{new_resource.path}\" /user:\"#{new_resource.domain_username}\" \"#{new_resource.domain_password}\""
  end
  
  execute "new_resource.printer_name" do
    command "RUNDLL32 PRINTUI.DLL,PrintUIEntry /Ss /n \"#{new_resource.printer_name}\" /a \"c:\\chef\\cache\\#{new_resource.file}\" d u g 8"
  end
  execute "Upload file" do
    command "move \"c:\\chef\\cache\\#{new_resource.file}\" \"z:\\\""
  end
  
  execute "Unmap Network Drive" do
    command "net use z: /d"
  end
end
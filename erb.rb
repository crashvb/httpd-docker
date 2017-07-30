#!/usr/bin/ruby

require 'cgi'
require 'erb'

$CGI = CGI.new
include ERB::Util

# To prevent the erb script to have access to "f"
bind = binding

puts "Content-Type: text/html\n\n"

# Check that the script is being executed through a redirect
if ENV["REQUEST_URI"] =~ /^#{ENV["SCRIPT_NAME"]}.*/
  puts "Script cannot be executed directly!"
else
  puts File.open($CGI.path_translated, "r") { |f| ERB.new(f.read).result(bind) }
end


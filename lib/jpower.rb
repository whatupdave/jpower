#!/usr/bin/env ruby
require 'rubygems'
require 'trollop'
require 'weaver'
require 'fileutils'

include FileUtils

opts = Trollop::options do
  version "jpower 0.0.1"
  banner <<-EOS
Blanket shows you test coverage on your javascript

Usage:
       blanket [options]
where [options] are:
EOS
  opt :file, "input file", :short => '-f', :type => String
  opt :directory, "input directory", :short => '-i', :type => String
  opt :out_dir, "output directory", :short => '-o', :type => String
  opt :excludes, "exclude js files", :short => '-x', :type => String, :multi => true
end

Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]
Trollop::die :directory, "must exist" unless File.exist?(opts[:directory]) if opts[:directory]

if opts[:file]
  javascript = ''
  File.open(opts[:file], "r") { |f|
      javascript = f.read
  }

  weaver = Weaver.new
  puts weaver.weave(opts[:file], javascript)
else
  # Recursively copy the first directory into the second
  cp_r opts[:directory], opts[:out_dir]

  Dir[opts[:out_dir] + '/**/*.js'].each do |f|
#    if f[]

  end
end
#
#javascript = ''
#File.open(opts[:directory], "r") { |f|
#    javascript = f.read
#}
#
#weaver = Weaver.new
#puts weaver.weave(opts[:directory], javascript)
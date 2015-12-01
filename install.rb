#!/usr/bin/env ruby

require 'fileutils'

Dir.foreach('.') do |item|
    next if item == '.' or item == '..' or item == 'install.rb' or item == 'README.md'
    FileUtils.ln_s(Dir.pwd + '/' + item, Dir.home + '/' + item, :force => true)
end

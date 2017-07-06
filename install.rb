#!/usr/bin/env ruby

require 'fileutils'
require 'set'
require 'optparse'

options = {}

OptionParser.new do |opts|
    opts.banner = "\nDotfile installer\n"
    
    opts.on("-d", "--dry-run", "Does a dry run") do |d|
        options[:dryrun] = d
    end
end.parse!

files_to_skip = Set.new([
    '.', '..', 'install.rb', 'README.md', '.git'
])

file_to_destination_map = {
    "config.fish" => "$HOME/.config/fish/config.fish",
    "settings.json" => "$HOME/Library/Application Support/Code/User/settings.json"
}

Dir.foreach('.') do |item|
    next if files_to_skip.include? item
    
    path_to_copy_to = Dir.home + '/' + item
    if file_to_destination_map.include? item
        path_to_copy_to = file_to_destination_map[item]
    end

    if options[:dryrun] === true
        puts "ln -s #{Dir.pwd + '/' + item} #{path_to_copy_to}"
    else 
        if !File.directory? path_to_copy_to
            FileUtils.mkdir_p(path_to_copy_to)
        end
        FileUtils.ln_s(Dir.pwd + '/' + item, path_to_copy_to, :force => true)
    end
end

#`source ~/.bashrc`

# install vim-plugged, if not already installed
#`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

# Do the install
#vim +PlugInstall

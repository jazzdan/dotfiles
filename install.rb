#!/usr/bin/env ruby

require 'fileutils'
require 'set'

files_to_skip = Set.new([
    '.', '..', 'install.rb', 'README.md'
])

file_to_destination_map = {
    "config.fish" => "$HOME/.config/fish/config.fish",
    "settings.json" => "$HOME/Library/Application Support/Code/User/settings.json"
}

Dir.foreach('.') do |item|
    next if files_to_skip.include? item

    path_to_copy_to = Dir.home + '/' + item
    if file_to_destination_map.include? item
        path_to_copy_to = file.file_to_destination_map[item]
    end

    FileUtils.ln_s(Dir.pwd + '/' + item, path_to_copy_to, :force => true)
end

#`source ~/.bashrc`

# install vim-plugged, if not already installed
#`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

# Do the install
#vim +PlugInstall

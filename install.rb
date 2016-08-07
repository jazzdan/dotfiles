#!/usr/bin/env ruby

require 'fileutils'

Dir.foreach('.') do |item|
    next if item == '.' or item == '..' or item == 'install.rb' or item == 'README.md'
    FileUtils.ln_s(Dir.pwd + '/' + item, Dir.home + '/' + item, :force => true)
end

`source ~/.bashrc`

# install vim-plugged, if not already installed
`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

# Do the install
vim +PlugInstall

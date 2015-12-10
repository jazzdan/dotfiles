#!/usr/bin/env ruby

require 'fileutils'

Dir.foreach('.') do |item|
    next if item == '.' or item == '..' or item == 'install.rb' or item == 'README.md'
    FileUtils.ln_s(Dir.pwd + '/' + item, Dir.home + '/' + item, :force => true)
end

`source ~/.bashrc`

# install Vundle, if not already installed
if !File.directory?('~/.vim/bundle/Vundle.vim')
    `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
end

# Do the vundle install
`vim +PluginInstall +qall`

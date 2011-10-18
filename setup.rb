#!/usr/bin/env ruby

# Slightly modified version of: http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen Thanks!

git_bundles = [ 
  "git://github.com/astashov/vim-ruby-debugger.git",
  "git://github.com/msanders/snipmate.vim.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/timcharper/textile.vim.git",
  "git://github.com/tpope/vim-cucumber.git",
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-git.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/godlygeek/tabular.git",
  "git://github.com/scrooloose/syntastic.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-endwise.git",
  "https://github.com/robgleeson/hammer.vim.git",
  "https://github.com/vim-scripts/JavaScript-Indent.git"
  # "git://github.com/tsaleh/vim-align.git",
]

vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  # ["gist",          "12732", "plugin"],
  ["jquery",        "12107", "syntax"],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

git_bundles.each do |url|
  dir = File.join(bundles_dir, url.split('/').last.sub(/\.git$/, '').sub('vim-', ''))
  puts "  Unpacking #{url} into #{dir}"
  `git submodule add #{url} #{dir}`
end

`git submodule update --init`

FileUtils.cd(bundles_dir)

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end

#!/usr/bin/env ruby

require 'fileutils'

puts "Setting up vim..."

def link_with_check(old, new)
  `diff #{old} #{new}`

  if $?.exitstatus == 0
    puts "Already linked #{old} to #{new}"
  else
    FileUtils.ln_s(old, new)
  end
rescue
  print "#{new} exists. Replace? (y/N) "
  if $stdin.gets.chomp.downcase == "y"
    puts "Replacing #{new}"
    FileUtils.ln_sf(old, new)
  else
    puts "Skipping #{new}"
  end
end

here = File.dirname(__FILE__)
vimpath = File.expand_path('vimrc', here)
link_with_check(vimpath, File.expand_path('~/.vimrc'))

gvimpath = File.expand_path('gvimrc', here)
link_with_check(gvimpath, File.expand_path('~/.gvimrc'))

git_bundles = [ 
  "https://github.com/corntrace/bufexplorer.git",
  "https://github.com/edsono/vim-matchit",
  "https://github.com/godlygeek/tabular.git",
  "https://github.com/kien/ctrlp.vim.git",
  "https://github.com/msanders/snipmate.vim.git",
  "https://github.com/othree/xml.vim.git",
  "https://github.com/rking/ag.vim.git",
  "https://github.com/scrooloose/nerdtree.git",
  "https://github.com/scrooloose/syntastic.git",
  "https://github.com/timcharper/textile.vim.git",
  "https://github.com/thoughtbot/vim-rspec",
  "https://github.com/tomasr/molokai.git",
  "https://github.com/tpope/vim-endwise.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/tpope/vim-git.git",
  "https://github.com/tpope/vim-haml.git",
  "https://github.com/tpope/vim-markdown.git",
  "https://github.com/tpope/vim-rails.git",
  "https://github.com/tpope/vim-repeat.git",
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/tpope/vim-vividchalk.git",
  "https://github.com/vim-scripts/IndexedSearch.git",
  "https://github.com/vim-scripts/JavaScript-Indent.git",
  "https://github.com/vim-scripts/tComment",
  "https://github.com/vim-scripts/ruby-matchit"
]

bundles_dir = File.expand_path('../bundle', __FILE__)

git_bundles.each do |url|
  bundle_name = url.split('/').last.sub(/\.git$/, '')
  clone_dir = File.join(bundles_dir, bundle_name)

  if File.directory?(clone_dir)
    puts
    puts "Already cloned #{bundle_name}"
  else
    puts
    puts "  Cloning #{url} into #{clone_dir}"
    `git clone #{url} #{clone_dir}`

    FileUtils.cd(clone_dir) do
      FileUtils.rm_rf(".git")
    end
  end
end

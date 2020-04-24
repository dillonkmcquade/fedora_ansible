mkdir ~/.vim/pack/vendor/start
cd ~/.vim/pack/vendor/start
git clone https://github.com/jiangmiao/auto-pairs.git
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/preservim/nerdtree.git
git clone https://github.com/sonph/onehalf.git
mv onehalf/vim/colors ~/.vim/
rm -rf onehalf
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/frazrepo/vim-rainbow.git
echo "Finished installing Vim repos"

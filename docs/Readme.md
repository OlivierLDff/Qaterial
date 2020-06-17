# Jekyll Documentation

## Setup environment

### Linux

```bash
# Install ruby
sudo apt install -y ruby-full build-essential zlib1g-dev
# Setup environment
echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
# Install bundler and jekyll
sudo gem install jekyll bundler
# Build website in this folder and serve it at localhost:4000
bundle exec jekyll serve --watch
```

## Build Website

```bash
# Build website in this folder and serve it at localhost:4000
bundle exec jekyll serve --watch
```

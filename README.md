# vim-karma

## Description
This is a lightweight Karma runner for Vim, like vim-rspec.

## Installation

Install vim plugin
```vim
    Bundle 'maksimr/vim-karma'
```

Install karma-cli
```bash
    npm install -g karma-cli
```

Install karma in porject
```bash
    npm install karma
```

## Configuration

Key mappings
Add your preferred key mappings to your .vimrc file.

```vim
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
```

All functions which run special file or test case actually only for mocha!

  * RunNearestSpec - Run nearest it
  * RunNearestTestCase - Run nearest it
  * RunNearestTestSuite - Run nearest describe
  * RunSpecs - By defaul run all specs. You can pass grep string how parrams `RunSpecs('Test')`

## Tests
For testing vim files we use [vim-vspec](https://github.com/kana/vim-vspec)

### Setup environment
Before run vim tests you should setup test environment.
Inside plugin directory run follow commands:

Before all steps you should install `ruby` and `gems`

This install all needed gems for tests
```bash
    gem install bundle
    bundle install
```

### The structure of directories
Files with tests for vim located in directory `t`

### Run
For executing vim tests you should run command:
```bash
    bundle exec rake test
```

### Watch
For run tests on every change of vim files
in folders `plugin` and `t`
```bash
    guard
```

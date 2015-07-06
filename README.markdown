## README

This is an example Ruby on Rails app that allows users to create shortened URLs.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

### Getting started

This app is setup to use ruby 2.2.2. You must have it installed or you can update
the Gemfile to use what version you like.

```
git clone git@github.com:mikeotoole/runturl.git
cd runturl
bundle install
bin/rake db:setup
bin/rake # This will run all specs and linters.
bin/rails s
```

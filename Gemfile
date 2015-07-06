source 'https://rubygems.org'

ruby '2.2.2'
gem 'coffee-rails', '~> 4.1.0'
gem 'foundation-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '4.2.3'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'
gem 'unicorn-worker-killer'
group :production, :staging do
  gem 'rails_12factor'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'brakeman'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'guard-rspec'
  gem 'rails_best_practices'
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'bullet'
  gem 'pry-rails'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

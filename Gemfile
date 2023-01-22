source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"


gem "rails", "~> 7.0.4", ">= 7.0.4.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'faraday'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-byebug'
  gem 'rubocop-rails', require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

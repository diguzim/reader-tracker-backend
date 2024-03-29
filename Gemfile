# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'pg'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.6', '>= 5.6.4'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.11.1', require: false

gem 'devise'
gem 'devise-jwt'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'debase'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 5.1.1'
  gem 'ruby-debug-ide'
end

group :development do
  gem 'listen', '~> 3.7.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'solargraph'
  gem 'spring'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker'
  gem 'shoulda-matchers', '~> 5.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'jwt', '~> 2.2'

gem 'pundit'

gem 'rack-cors'

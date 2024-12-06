# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'active_model_serializers', '~> 0.10.15'
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.4', '>= 7.1.4.1'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.4'
  gem 'faker', '~> 3.4', '>= 3.4.2'
  gem 'json-schema', '~> 5.1', '>= 5.1.1'
  gem 'pry', '~> 0.14.0'
  gem 'rspec', '~> 3.4'
  gem 'rspec-rails', '~> 7.1'
  gem 'shoulda-matchers', '~> 6.2'
end

group :development do
  gem 'annotate'
  gem 'fasterer', '~> 0.11.0'
  gem 'rubocop', '~> 1.69', '>= 1.69.1'
  gem 'rubocop-rails', '~> 2.27'
  gem 'rubocop-rspec', '~> 3.2'
end

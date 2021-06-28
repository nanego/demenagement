source 'https://rubygems.org'
ruby '2.6.6'
gem 'rails', '5.2.4.5'
gem 'rails-i18n'
gem 'sassc-rails', '~> 2.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.0'
gem 'administrate'
gem 'sprockets', '~>3.0'

gem 'bourbon'
gem "bootstrap-sass", ">= 3.4.1"
# gem 'bootstrap-generators', git: 'git://github.com/decioferreira/bootstrap-generators.git'
gem 'bootstrap-generators', '~> 3.3.4'

# Authentication
gem 'omniauth', '>= 1.1.1'
gem 'omniauth-cas', '= 1.1.1'
gem 'devise'
gem 'devise-i18n'
gem 'devise_invitable'
gem 'simple_token_authentication', '~> 1.0'

gem 'high_voltage'
gem 'pg'
gem 'simple_form'
gem 'datagrid'
gem 'kaminari'
gem 'virtus'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

group :development do
  gem 'web-console', '~> 2.0'
  # gem 'spring'
  gem 'better_errors'
  # gem 'quiet_assets'
  gem 'rails_layout'
  gem 'meta_request'
  gem 'listen'
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'puma'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'bullet'
  gem 'rack-mini-profiler'
  gem 'byebug'
  gem 'rails-controller-testing'
  gem 'active_record_doctor'
  gem 'simplecov', require: false
end
group :test do
  gem 'minitest-rails-capybara'
end
group :production do
  gem 'passenger'
  gem 'therubyracer'
end
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'acts_as_list'
gem 'public_activity', git: 'https://github.com/pokonski/public_activity.git'
gem 'friendly_id', '~> 5.2'
gem 'record_tag_helper', '~> 1.0' # Add helpers removed from Rails core in Rails 5

# Manage file uploads
gem 'shrine', '~> 3.4'

# Add email notifications on errors
gem 'exception_notification'
gem 'letter_opener', group: :development

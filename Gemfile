source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '3.2.13'

group :development do
  gem 'mysql2'
end


# gem "thin", "~> 1.5.0"

group :production do
	gem 'pg', '0.15.1'
  gem 'memcachier', '0.0.2'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
 # gem 'jquery-ui-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# logentries
#gem 'le'

gem 'jquery-fileupload-rails', '0.4.1'
# gem "jquery-rails", "2.1.4"
gem "jquery-rails", "~> 2.2.1"

gem "rack-no-www", "~> 0.0.2"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
  gem 'unicorn', '4.6.3'

# Deploy with Capistrano
  gem 'capistrano', '2.15.5'


# authentication
gem 'devise', '3.0.0'
gem "omniauth-facebook", '1.4.1'

# for Amazon S3 storage and other clouds services
gem 'fog', '1.12.1'

# A wrapper to the  Amazon Product Advertising API
# gem "vacuum", "~> 0.3.0" # GOOD GEM BUT NOT USED


# file uploading
gem 'carrierwave', '0.6.2'
# image processing
gem "rmagick", '2.13.2'

# enables remote multipart forms (AJAX style file uploads) with jQuery.
gem 'remotipart', '~> 1.0'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


gem 'rack-cache', :require => 'rack/cache'


gem 'dalli', '2.6.4'

gem 'dragonfly', '~>0.9.12'


# provides simple API for performing paginated queries with Active Record & more
gem "will_paginate", "~> 3.0.3"

# a utility for annotation of fields in model file

# tinymce - wysiwyg
#gem "tinymce-rails"#, "~> 3.5.8"

# Used for product categories
gem "acts-as-taggable-on", "~> 2.3.3"

# Organise ActiveRecord model into a tree structure, used for the (product) categories
gem "ancestry", "~> 1.3.0"

# allows to easily add Growl-like notifications to application using a jQuery plugin called 'gritter'.
gem "gritter", "~> 1.0.2"

# Ruby SDK for Facebook
gem "koala", "~> 1.6.0"

# Client Side profiling, DB profiling and Server profiling
# GREAT GEM, DISABLED WHILE NOT TROUBLESHOOTING # gem "rack-mini-profiler", "~> 0.1.23"

# Google Picasa managment
gem "picasa", "~> 0.6.2"

# Create plain old ruby models without activeModel (db table).
# Used for the validation of contact us form
#gem "active_attr", "~> 0.7.0"

# Queueing worker
# gem 'sidekiq'

# to detect location (country/city)
gem 'geocoder','1.1.8'

# Render QR codes
gem 'mini_magick', '3.6.0'
gem 'rqrcode-rails3', '0.1.6'

# for getting email on exceptions
gem 'exception_notification', '3.0.1'
gem 'letter_opener', group: :development

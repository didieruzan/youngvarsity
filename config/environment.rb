# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Yv::Application.initialize!

# if Rails.env.production?
#   Rails.logger = Le.new(ENV["LOGENTRIES_TOKEN"], true)
# end
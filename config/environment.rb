# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!



  ActionMailer::Base.smtp_settings = {
  address:              "smtp.gmail.com",
  port:                 587,
  domain:               "gmail.com",
  user_name:            'food.drind.framgia@gmail.com',
  password:             'Fuck@123',
  authentication:       :plain,
  enable_starttls_auto: true
}

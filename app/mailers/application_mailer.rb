class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('EMAIL_USERNAME', nil)
  layout 'mailer'
end

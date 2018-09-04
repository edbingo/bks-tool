class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@localhost:3000'
  layout 'mailer'
end

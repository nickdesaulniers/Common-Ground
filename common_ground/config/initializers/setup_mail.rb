ActionMailer::Base.smtp_settings = {
  address:             'smtp.gmail.com',
  port:                 587,
  domain:               'mail.gmail.com',
  user_name:            'mailer.commonground@gmail.com',
  password:             'mozillamozilla',
  authentication:       'plain',
  enable_starttls_auto: true
}
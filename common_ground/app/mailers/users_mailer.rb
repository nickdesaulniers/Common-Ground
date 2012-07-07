class UsersMailer < ActionMailer::Base
  def invite user
    @user = user
    mail to: user.email, subject: 'Find Common Ground',
      from: 'mailer.commonground@gmail.com'
  end
end

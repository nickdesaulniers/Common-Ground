class UsersMailer < ActionMailer::Base
  def invite user, room
    @user = user
    @room = room
    mail to: user.email, subject: 'Find Common Ground',
      from: 'mailer.commonground@gmail.com'
  end
end

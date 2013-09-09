# encoding: UTF-8
class UsersMailer < ActionMailer::Base
  default :from => '"The Village" <noreply@the-village.ru>'

  def user_created(user)
    @user = user
    mail( :to => user.email,
          :subject => 'Создание екаунта!')
  end
end

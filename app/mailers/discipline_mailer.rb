# encoding: UTF-8
class DisciplineMailer < ActionMailer::Base
  default :from => '"The Village" <noreply@the-village.ru>'

  def send_confirm(discipline)
    @discipline = discipline
    mail( :to => discipline.user_email,
          :subject => 'Подтверждение созданой дисциплины!')
  end

  def rejected_email(discipline)
    @discipline = discipline
    mail( :to => discipline.user_email,
          :subject => 'Your discipline proposal was declined!')
  end

  def approved_email(discipline)
    @discipline = discipline
    mail( :to => discipline.user_email,
          :subject => 'Your discipline proposal was approved!')
  end

  def winner_email(discipline)
    @discipline = discipline
    mail( :to => discipline.user_email,
          :subject => 'Вы победитель')
  end
end

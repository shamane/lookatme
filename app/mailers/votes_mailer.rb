# encoding: UTF-8
class VotesMailer < ActionMailer::Base
  default :from => '"The Village" <noreply@the-village.ru>'

  def send_confirm(vote)
    @vote = vote
    mail( :to => vote.user_email,
          :subject => 'Ваш голос был добавлен!')
  end
end

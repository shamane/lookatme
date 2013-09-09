class Vote < ActiveRecord::Base
  default_scope { where('confirmed_at is not NULL') }

  belongs_to :user
  belongs_to :discipline

  attr_accessible :user, :discipline, :confirmation_token, :confirmed_at

  delegate :name, :email, :to => :user, :prefix => true

  scope :confirmed, lambda { where('confirmed_at is not NULL') }

  scope :upcoming, lambda { |user, discipline|
    {:conditions => ["user_id = ? and discipline_id = ? and date(updated_at) > ?", user, discipline, DateTime.now - 1.day]}
  }

  after_create :generate_token
  after_create :send_confirmation
  after_destroy :decrease_counter

  def confirm!
    update_attributes(:confirmed_at => DateTime.now)
    discipline.votes_count += 1
    discipline.save
  end

  private

  def generate_token
    token = Token.generate
    update_attributes(:confirmation_token => token)
  end

  def send_confirmation
    VotesMailer.send_confirm(self).deliver
  end

  def decrease_counter
    discipline.votes_count -= 1
    discipline.save
  end
end

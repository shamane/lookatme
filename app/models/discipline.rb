class Discipline < ActiveRecord::Base
  include Stateflow

  WINNERS_LIMIT = 10

  attr_accessible :description, :name, :confirmation_token, :confirmed_at, :state

  has_many :votes

  has_one :photo, :dependent => :destroy

  belongs_to :user

  validates :description, :name, :presence => true

  delegate :name, :email, :to => :user, :prefix => true, :allow_nil => true

  scope :confirmed, lambda { where('confirmed_at is not NULL') }
  scope :pending,   lambda { where(:state => 'pending') }
  scope :approved,  lambda { where(:state => 'approved') }
  scope :rejected,  lambda { where(:state => 'rejected') }
  scope :notnull,   lambda { where('votes_count > 0') }
  scope :winners,   approved.order("votes_count DESC limit #{WINNERS_LIMIT}")

  after_create :generate_token
  after_create :send_confirmation

  stateflow do
    initial :pending

    state :pending, :rejected, :approved

    state :rejected do
      enter :send_rejected_notification!
    end

    state :approved do
      enter :send_approved_notification!
    end

    event :approve! do
      transitions :from => :pending, :to => :approved
    end

    event :reject! do
      transitions :from => :pending, :to => :rejected
    end
  end

  class << self
    def by_tournament_state
      if Settings.first.state == 'started'
        Discipline.approved
      else
        Discipline.winners
      end
    end
  end

  def confirm!
    update_attributes(:confirmed_at => DateTime.now)
  end

  def vote_up(user)
    votes.create(:user => user)
  end

  def send_emails
    DisciplineMailer.winner_email(self).deliver
  end

  private

  def generate_token
    token = Token.generate
    update_attributes(:confirmation_token => token)
  end

  def send_confirmation
    DisciplineMailer.send_confirm(self).deliver
  end

  def send_rejected_notification!
    DisciplineMailer.rejected_email(self).deliver
  end

  def send_approved_notification!
    DisciplineMailer.approved_email(self).deliver
  end



end

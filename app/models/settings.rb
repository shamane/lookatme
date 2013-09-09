class Settings < ActiveRecord::Base
  include Stateflow

  attr_accessible :state

  stateflow do
    initial :stoped

    state :stoped, :started

    event :tournament_start! do
      transitions :from => :stoped, :to => :started
    end

    event :tournament_stop! do
      transitions :from => :started, :to => :stoped
    end
  end

  class << self
    def are_tournaments_started?
      Settings.first.state == 'started'
    end
  end
end

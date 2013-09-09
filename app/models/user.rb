class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :disciplines, :confirmation_token, :confirmed_at

  has_many :disciplines

  attr_accessible :disciplines_attributes

  accepts_nested_attributes_for :disciplines

  validates :email, :presence => true
  validates :email, :uniqueness => true

  after_create :generate_token
  # after_create :email_confirmation
  after_create :confirm!

  def is_admin?
    email == 'admin@lookatme.ru'
  end

  def confirmed?
    !!confirmed_at
  end

  def confirm!
    update_attributes(:confirmed_at => DateTime.now)
  end

  private

  def generate_token
    token = Token.generate
    update_attributes(:confirmation_token => token)
  end

  def email_confirmation
    UsersMailer.user_created(self).deliver
  end
end

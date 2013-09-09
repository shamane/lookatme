namespace :admin do
  # admin:create
  desc "add admin role to user with specific email"
  task :create => :environment do
    user = User.create( :email => 'admin@lookatme.ru',
                        :password => 'zaq1xsw2qwer',
                        :password_confirmation => 'zaq1xsw2qwer')
    user.confirm!
  end
end

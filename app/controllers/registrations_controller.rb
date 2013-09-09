class RegistrationsController < Devise::RegistrationsController

  def new
    super
    @user.disciplines.build
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      @discipline = @user.disciplines.create(params[:disciplines])
      @discipline.save
    else
      @user = User.new(params[:user])
      if @user.save
        @discipline = @user.disciplines.build(params[:disciplines])
        @discipline.save
      else
        render :action => :new
      end
    end
    redirect_to :action => :new
  end
end

class Admin::PhotosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_user_admin
  before_filter :find_discipline, :only => [:create]

  def create
    @discipline.photo = Photo.new(params[:photo])
    @discipline.save
    redirect_to winners_admin_disciplines_path
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to winners_admin_disciplines_path
  end

  private

  def find_discipline
    @discipline = Discipline.find_by_id(params[:discipline_id])
  end
end

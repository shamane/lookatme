class Photo < ActiveRecord::Base
  attr_accessible :photo_content_type, :photo_created_at, :photo_file_name, :photo_file_size, :photo_updated_at, :photo
  belongs_to :discipline

  has_attached_file :photo,
  :styles => { :original => '' },
  :path => "#{::Rails.root}/public/winners/:basename.:extension"
end

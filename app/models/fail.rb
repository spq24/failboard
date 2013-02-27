class Fail < ActiveRecord::Base
  attr_accessible :description, :image, :image_url
  make_voteable

  belongs_to :user
  mount_uploader :image, ImageUploader

	validates            :description, length: { :maximum => 300 }
	validates            :user_id, presence: true
	validates            :image, presence: true

	
  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end


end

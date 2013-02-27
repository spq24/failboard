class Fail < ActiveRecord::Base
  attr_accessible :description, :image, :image_url, :fail_title
  make_voteable

  belongs_to :user
  mount_uploader :image, ImageUploader

	validates            :description, length: { :maximum => 300 }
	validates            :user_id, presence: true
	validates            :image, presence: true
  validates            :fail_title, presence: true, length: { :maximum => 50 }

	
  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end


end

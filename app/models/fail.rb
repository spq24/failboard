class Fail < ActiveRecord::Base
  attr_accessible :description, :image, :remote_image_url, :fail_title, :tag_list
  make_voteable
  acts_as_taggable

  belongs_to :user
  mount_uploader :image, ImageUploader

	validates            :description, length: { :maximum => 200 }
	validates            :user_id, presence: true
	validates            :image, presence: true
  	validates            :fail_title, presence: true, length: { :maximum => 50 }
  	validate 			 :maximum_amount_of_tags


	def maximum_amount_of_tags
		number_of_tags = tag_list_cache_on("tags").uniq.length
		errors.add(:base, "Please only add up to 5 tags") if number_of_tags > 5
	end

end

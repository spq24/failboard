class Fail < ActiveRecord::Base
  attr_accessible :description, :image, :remote_image_url, :fail_title, :tag_list, :processed, :youtube_url, :album_id
  make_voteable
  acts_as_taggable

  belongs_to :album

  mount_uploader :image, ImageUploader
 

	validates            :description, length: { :maximum => 200 }
	validates            :album_id, presence: true
	validates            :image, presence: true
  validates            :fail_title, presence: true, length: { :maximum => 50 }
  validate 			       :maximum_amount_of_tags


  	def maximum_amount_of_tags
  		number_of_tags = tag_list_cache_on("tags").uniq.length
  		errors.add(:base, "Please only add up to 5 tags") if number_of_tags > 5
  	end

    before_save :update_attachment_attributes
   
    def update_attachment_attributes
      if image.present? && image_changed?
        self.content_type = image.file.content_type
        self.file_size = image.file.size
      end
    end

    def next
    	user.fails.where("id > ?", id).order("id ASC").first
  	end

  	def prev
    	user.fails.where("id < ?", id).order("id DESC").first
  	end


end

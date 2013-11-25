class Album < ActiveRecord::Base
	attr_accessible :name, :image, :image_url, :created_at

	belongs_to :user
  has_many :fails, dependent: :destroy


  mount_uploader :image, ImageUploader
 

	validates            :user_id, presence: true
	validates            :image, presence: true
 	validates            :name, presence: true, length: { :maximum => 50 }



    before_save :update_attachment_attributes
   
    def update_attachment_attributes
      if image.present? && image_changed?
        #self.content_type = image.file.content_type 
        #self.file_size = image.file.size
      end
    end

    def next
    	user.fails.where("id > ?", id).order("id ASC").first
  	end

  	def prev
    	user.fails.where("id < ?", id).order("id DESC").first
  	end

end

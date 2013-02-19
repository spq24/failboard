class Pin < ActiveRecord::Base
	attr_accessible :description, :image


	validates            :description, presence: true, length: { :maximum => 140 }
	validates            :user_id, presence: true
	validates_attachment :image, presence: true,
								 content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
								 size: { less_than: 5.megabytes }

	belongs_to :user
	has_attached_file :image

  def to_jq_upload
    {
      "name" => read_attribute(:image_file_name),
      "size" => read_attribute(:image_file_size),
      "url" => upload.url(:original),
      "delete_url" => image_path(self),
      "delete_type" => "DELETE" 
    }
  end


end

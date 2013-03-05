ActiveAdmin.register Fail do

	index do
		column :id
		column "Fail Title", :fail_title
		column "Number of LOLs", :up_votes
		column :description
		column :image
		column "Link to Image (if that's how it was uploaded)", :remote_image_url
		column "Fail Uploaded On:", :created_at
		column "Fail Updated On:", :updated_at
		default_actions  
	end

end

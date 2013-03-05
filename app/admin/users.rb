ActiveAdmin.register User do

	index do
		column :id
		column :email
		column :name
		column "Last Sign In Date & Time", :last_sign_in_at
		column :last_sign_in_ip
		column "Created at Date", :created_at
		column :updated_at
		column "Number of LOL's by User", :up_votes
		column "Sign Up Provider", :provider
		default_actions
	end
  
end

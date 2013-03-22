class UsersController < ApplicationController
  	def show
 		@user = User.find(params[:id])
 		@fails = @user.fails
	end
end

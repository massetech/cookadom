class CooksController < ApplicationController
before_action :find_cook, only: [:update, :edit, :destroy]
before_action :authenticate_user!, except: [:index]

	def index
		@cooks = Cook.all
	end

	def new
		@cook = current_user.build_cook
	end

	def create
		@cook = current_user.build_cook(cook_params)
		if @cook.save
			redirect_to users_path, notice: "Le cuisinier a bien été crée !"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
	end

	def destroy
		Recipe.where(user_id: @cook.user_id).destroy_all
		@cook.destroy
		redirect_to users_path, notice: 'Le cuisinier a bien été détruit avec les recettes...'
	end

	private

	def find_cook
		@cook = Cook.find(params[:id])
	end

	def cook_params
		params.require(:cook).permit(:name, :postal_code, :working_distance, :introduction)
	end

end

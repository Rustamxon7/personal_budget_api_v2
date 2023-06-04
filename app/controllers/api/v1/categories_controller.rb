module Api
  module V1
    class CategoriesController < ApplicationController

      def create
        @user = current_user        
        
        @category = @user.categories.build(category_params)

        if params[:category][:members_ids].present?
          params[:category][:members_ids].each do |member_id|
            @category.members << Member.find(member_id)
          end
        end
        
        if @category.save
          render json: @category, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:name, :icon, :member_id, :kind, :members_ids => [])
      end
    end    
  end
end
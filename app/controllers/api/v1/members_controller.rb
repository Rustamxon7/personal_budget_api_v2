module Api
  module V1
    class MembersController < ApplicationController
      def create
        username = params[:username]
        user_id = current_user.id
        image = params[:image]

        @member = Member.new(username: username, user_id: user_id, image: image)

        if @member.save
          render json: @member, status: :created
        else
          render json: @member.errors, status: :unprocessable_entity
        end
      end
    
      private
    
      def member_params
        params.require(:member).permit(:username, :user_id, :image)
      end
    end    
  end
end